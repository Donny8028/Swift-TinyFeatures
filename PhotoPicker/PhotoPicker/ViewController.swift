//
//  ViewController.swift
//  PhotoPicker
//
//  Created by 賢瑭 何 on 2016/6/1.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        photoView.layer.cornerRadius = photoView.bounds.width / 2
        photoView.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
        photoView.addGestureRecognizer(tap)
    }
    
    func tapAction(gesture: UITapGestureRecognizer) {
        if gesture.numberOfTapsRequired == 1 {
            textField.resignFirstResponder()
            let picker = ImagePickerSheetController(mediaType: .Image)
            picker.addAction(ImagePickerAction(title: "Pick a photo", secondaryTitle: "Use this photo", style: .Default, handler: { action in
                self.camera()
                }, secondaryHandler: { (action, index) in
                    var images = [UIImage]()
                    let assets = picker.selectedImageAssets
                    for asset in assets {
                        if asset.mediaType == .Image {
                            let imageManager = PHImageManager.defaultManager()
                            imageManager.requestImageForAsset(asset, targetSize: self.photoView.bounds.size, contentMode: .AspectFill, options: nil, resultHandler: {image, info in
                                if assets.count == 1 {
                                    self.photoView.image = image
                                }else{
                                    images.append(image!)
                                    self.photoView.image = images[0]
                                }
                            })
                        }
                    }
            }))
            picker.addAction(ImagePickerAction(cancelTitle: "Cancel"))
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func camera() {
        
    }
}

