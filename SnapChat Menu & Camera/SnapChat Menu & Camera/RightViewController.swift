//
//  RightViewController.swift
//  SnapChat Menu & Camera
//
//  Created by 賢瑭 何 on 2016/5/13.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
    
    var imageView = UIImageView()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(imageView)
        imageView.image = UIImage(named: "right")
        imageView.frame = view.frame
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

}
