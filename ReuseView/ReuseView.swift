//
//  ReuseView.swift
//  ReuseView
//
//  Created by js on 16/9/7.
//  Copyright © 2016年 js. All rights reserved.
//

import UIKit


class ReuseView: UIScrollView {

    class Item{
        let title: String
        init(title: String){
            self.title = title
        }
    }
    
    var items: [Item]?{
        didSet{
            self.contentSize = contentItemSize
        }
    }
    
    init(){
        super.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeUI()
    }
    
    func width(forItem item: Item? = nil) -> CGFloat{
        return 60
    }
    
    
    var totalCount: Int{
        return items?.count ?? 0
    }
    

    lazy var useView = [UILabel]()
    lazy var reuseView = [UILabel]()
    
    var contentItemSize: CGSize{
        var sum:CGFloat = 0
        if let items = items{
            for item in items{
                sum += width(forItem: item)
            }
        }
        return CGSize(width: sum, height: 0)
    }
    
    func removeAllSubViews(){
        reuseView.insertContentsOf(useView, at: 0)
        useView.removeAll()
  
    }
    
    func makeUI(){
        removeAllSubViews()
        let visibleRangeResult = visibleRange()
        
        var originX = visibleRangeResult.0
        let visibleIndexs = visibleRangeResult.1
       
        for index in visibleIndexs{
            let item = items?[index]
            
            var label = reuseView.first
            if label == nil{
                label = UILabel()
                label?.backgroundColor = UIColor.greenColor()
                addSubview(label!)
            } else{
                reuseView.removeFirst()
            }
            
            label?.text = item?.title
            
            let itemWidth = width(forItem: item)
            let frame = CGRect(x: originX, y: 0, width: itemWidth, height: bounds.size.height)
            label?.frame = frame
            originX += itemWidth
            
            useView.append(label!)
            
        }
    }
    
    func visibleRange() ->(CGFloat,Range<Int>){
        var startIndex: Int?
        var endIndex: Int?
        var startOriginX: CGFloat?
        var totalX: CGFloat = 0
        let visibleSizeRange = contentOffset.x..<contentOffset.x + bounds.size.width
        
        for i in 0..<totalCount{
            let currentItemWidth = width()
            if (totalX >= visibleSizeRange.start && totalX <= visibleSizeRange.end) ||
            (totalX + currentItemWidth >= visibleSizeRange.start && totalX + currentItemWidth <= visibleSizeRange.end){
                if startIndex == nil{
                    startIndex = i
                    startOriginX = totalX
                }
                
                endIndex = i
            }
            
            totalX += currentItemWidth
        }
        return (startOriginX ?? 0,(startIndex ?? 0)...(endIndex ?? 0))
    }

}
