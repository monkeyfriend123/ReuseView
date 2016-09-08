//
//  ViewController.swift
//  ReuseView
//
//  Created by js on 16/9/7.
//  Copyright © 2016年 js. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var reuseView = ReuseView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var items = Array<ReuseView.Item>()//[ReuseView.Item]()
        for i in 0..<100{
            let item = ReuseView.Item(title: "文字 \(i)")
            items.append(item)
        }
        
        reuseView.backgroundColor = UIColor.yellowColor()
        reuseView.translatesAutoresizingMaskIntoConstraints = false
        reuseView.items = items
        view.addSubview(reuseView)
        
        func addConstraint(){
            let hPadding = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[reuseView]-10-|", options: [], metrics: nil, views: ["reuseView":reuseView])
            let vPadding = NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[reuseView]", options: [], metrics: nil, views: ["reuseView":reuseView])
            let vSize = NSLayoutConstraint.constraintsWithVisualFormat("V:[reuseView(50)]", options: [], metrics: nil, views: ["reuseView":reuseView])
            NSLayoutConstraint.activateConstraints(hPadding)
            NSLayoutConstraint.activateConstraints(vPadding)
            NSLayoutConstraint.activateConstraints(vSize)
        }
        
        addConstraint()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

