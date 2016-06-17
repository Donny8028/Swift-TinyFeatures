//
//  PickerViewController.swift
//  SnapChat Menu & Camera
//
//  Created by 賢瑭 何 on 2016/5/13.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit
import AVFoundation

class PickerViewController: UIViewController {
    
    
    var avCaptureDevice: AVCaptureDevice?
    var session: AVCaptureSession?
    var preViewlayer: AVCaptureVideoPreviewLayer?
    var output: AVCaptureStillImageOutput?
    var input: AVCaptureDeviceInput?
    
    var cameraView = UIView()
    
    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cameraView)
        cameraView.frame = view.frame
        // Do any additional setup after loading the view.
        avCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            input = try AVCaptureDeviceInput(device: avCaptureDevice)
        }
        catch let e as NSError{
           print("\(e.localizedDescription)")
            input = nil
        }
        output = AVCaptureStillImageOutput()
        output?.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        session = AVCaptureSession()
        session?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        guard let _ = session?.canAddInput(input) else{
            print("can't add input")
            return
        }
        guard let _ = session?.canAddOutput(output) else {
            print("can't add output")
            return
        }
        session?.addInput(input)
        session?.addOutput(output)
        preViewlayer = AVCaptureVideoPreviewLayer(session: session)
        preViewlayer?.videoGravity = AVLayerVideoGravityResize
        preViewlayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
        cameraView.layer.addSublayer(preViewlayer!)
        session?.startRunning()
    }
    
    
    func fetchPhoto() {
        imageView = UIImageView()
        cameraView.addSubview(imageView!)
        let connection = output?.connectionWithMediaType(AVMediaTypeVideo)
        output?.captureStillImageAsynchronouslyFromConnection(connection){ (sampleBuffer, error) in
            if sampleBuffer != nil && error == nil {
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                let image = UIImage(data: imageData)
                self.imageView?.image = image
                self.imageView?.frame = self.cameraView.frame
                self.imageView!.hidden = false
            }else{
                print("\(error.localizedDescription)")
            }
        }
        
    }
    
    var didTakePhoto = Bool()
    
    func didPressTakeAnother(){
        if didTakePhoto == true{
            imageView?.hidden = true
            didTakePhoto = false
            
        }else{
            didTakePhoto = true
            fetchPhoto()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        session?.stopRunning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        view.addGestureRecognizer(tap)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        preViewlayer?.frame = cameraView.bounds
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        if gesture.numberOfTapsRequired == 1 {
            didPressTakeAnother()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
