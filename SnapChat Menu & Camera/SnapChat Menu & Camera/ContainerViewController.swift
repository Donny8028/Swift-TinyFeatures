//
//  ViewController.swift
//  SnapChat Menu & Camera
//
//  Created by 賢瑭 何 on 2016/5/13.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    var right = RightViewController()
    var picker = PickerViewController()
    var left = LeftViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setNeedsStatusBarAppearanceUpdate()
        
        self.addChildViewController(left)
        scrollView.addSubview(left.view)
        left.didMoveToParentViewController(self)
        
        self.addChildViewController(right)
        scrollView.addSubview(right.view)
        var frame = right.view.frame
        frame.origin.x = view.frame.width
        right.view.frame = frame
        right.didMoveToParentViewController(self)
        
        var frameDouble = picker.view.frame
        frameDouble.origin.x = view.frame.width * 2
        self.addChildViewController(picker)
        scrollView.addSubview(picker.view)
        picker.view.frame = frameDouble
        // Cause the pickerView are disgned by programming, so when the View shows up with autolayout, it would offset.
        // So we need reset the width and height in the view will appear to resize it, otherwise , the take photo would not be activated.
        picker.didMoveToParentViewController(self)
        scrollView?.contentSize = CGSize(width: view.frame.width * 3 , height: view.frame.height)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        picker.view.frame = CGRectMake(view.frame.width * 2, 0.0, picker.cameraView.frame.width , picker.cameraView.frame.height)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
}

