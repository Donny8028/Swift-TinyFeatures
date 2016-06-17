//
//  LeftViewController.swift
//  SnapChat Menu & Camera
//
//  Created by 賢瑭 何 on 2016/5/14.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    
    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: "left")
        view.addSubview(imageView)
        imageView.image = image
        imageView.frame = view.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
