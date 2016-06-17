//
//  ViewController.swift
//  Project 1 - Simple Stop Watch
//
//  Created by 賢瑭 何 on 2016/5/10.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var secondTimer: UILabel!
    
    private var currentTime: NSTimeInterval?
    private var startWithTimer: NSTimer?
    private var stopTime: String?
    private var secondStopTime: String?
    private var newStopTime: String?
    private var newSecondTime: String?
    private var timerStatus = false
    private var forOneTime = false
    private var buttonSecure = false
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var pause: UIButton!
    
    
    
    @IBAction func reset() {
        timer.text = "00"
        secondTimer.text = "00"
        startWithTimer?.invalidate()
        timerStatus = false
        start.enabled = !buttonSecure
        pause.enabled = buttonSecure
    }
    
    @IBAction func startTimer() {
        startWithTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        currentTime = NSDate.timeIntervalSinceReferenceDate()
        forOneTime = true
        start.enabled = buttonSecure
        pause.enabled = !buttonSecure
    }
    
    
    @IBAction func stopTimer() {
        if startWithTimer?.valid == true {
            startWithTimer?.invalidate()
            timerStatus = true
            start.enabled = !buttonSecure
            pause.enabled = buttonSecure
            if newStopTime != nil {
                stopTime = newStopTime!
            }
            if newSecondTime != nil {
                secondStopTime = newSecondTime
            }
        }
    }
    
    var plusMillisecond:UInt?
    var plusSecond:UInt?
    
    func updateTimer() {

        let fromCurrentTime = NSDate.timeIntervalSinceReferenceDate()
        var timePassed = fromCurrentTime - currentTime!
        let second = UInt(timePassed)
        timePassed -= NSTimeInterval(second)
        let millisecond = UInt(timePassed * 100)
        if !timerStatus {
            let secondText = String(format: "%02d", second)
            let millisecondText = String(format: "%02d", millisecond)
            timer.text = "\(secondText)"
            stopTime = timer.text
            secondTimer.text = "\(millisecondText)"
            secondStopTime = secondTimer.text
            
        }else {
                if forOneTime { //Grab the data one time
                    plusSecond = UInt(stopTime!)
                    plusMillisecond = UInt(secondStopTime!)
                }
                if plusSecond != nil && plusMillisecond != nil {
                    
                    plusMillisecond! += 1
                    let secondText = String(format: "%02d", plusSecond!)
                    let millisecondText = String(format: "%02d", plusMillisecond!)
                    newStopTime = "\(secondText)"
                    newSecondTime = "\(millisecondText)"
                    timer.text = newStopTime
                    secondTimer.text = newSecondTime
                    forOneTime = false
                    if plusMillisecond == 99 {
                        
                        plusMillisecond = 0
                        plusSecond! += 1
                    }
                }
            }
        
        if timer.text == "60" {
            startWithTimer?.invalidate()
            timer.text = "00"
            secondTimer.text = "00"
            stopTime = nil
            timerStatus = false
            let timeUpAlert = UIAlertController(title: "Time's up", message: "", preferredStyle: .Alert)
            let alert = UIAlertAction(title: "OK", style: .Default, handler: { action in
                self.start.enabled = !self.buttonSecure
                self.pause.enabled = self.buttonSecure
            })
            timeUpAlert.addAction(alert)
            presentViewController(timeUpAlert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timer.text = "00"
        secondTimer.text = "00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
        //Only for black background usage.
    }
}
