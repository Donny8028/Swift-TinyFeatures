//
//  ViewController.swift
//  TileMosaicView
//
//  Created by 賢瑭 何 on 2016/6/2.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,FMMosaicLayoutDelegate {
    
    var imageArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout = FMMosaicLayout()
        collectionView?.collectionViewLayout = layout
        layout.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 10
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        let imageView = cell.viewWithTag(2) as? UIImageView
        imageView?.image = UIImage(named: imageArray[indexPath.row])
        cell.alpha = 0.0
        
        let randomDelay = Double(arc4random_uniform(601) / 1000)
        
        UIView.animateWithDuration(0.8, delay: randomDelay, options: .CurveEaseOut, animations: {
            cell.alpha = 1.0
            }, completion: nil)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAtIndexPath indexPath: NSIndexPath!) -> FMMosaicCellSize {
        return indexPath.row % 7 == 0 ? FMMosaicCellSize.Big : FMMosaicCellSize.Small
    }
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
}

