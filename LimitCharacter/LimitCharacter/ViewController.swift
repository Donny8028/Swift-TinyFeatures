//
//  ViewController.swift
//  LimitCharacter
//
//  Created by 賢瑭 何 on 2016/5/24.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var messageView: UITextView!
    
    @IBOutlet weak var charactersLeft: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        messageView.delegate = self
        messageView.becomeFirstResponder()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let counts = textView.text.characters.count
        
        if range.location >= 140 {
            return false
        }
        
        return counts <= 140
    }
    
    func textViewDidChange(textView: UITextView) {
        let counts = textView.text.characters.count
        charactersLeft.text = "\(140 - counts)"
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo![UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        let height = keyboardFrame?.size.height
        bottomView.transform = CGAffineTransformMakeTranslation(0.0, -height!)
    }
    
    func keyboardWillHide(notifcation: NSNotification) {
        bottomView.transform = CGAffineTransformIdentity
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
}

