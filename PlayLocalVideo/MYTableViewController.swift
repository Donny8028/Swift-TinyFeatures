//
//  MYTableViewController.swift
//  PlayLocalVideo
//
//  Created by 賢瑭 何 on 2016/5/12.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MYTableViewController: UITableViewController {
    
    private var video = [
        VideoInfo(title: "Introduce 3DS Mario", image:UIImage(named: "videoScreenshot01")!, source: "Youtube"),
        VideoInfo(title: "Emoji Among Us", image: UIImage(named:"videoScreenshot02")!, source: "Vimeo"),
        VideoInfo(title: "Seals Documentary", image: UIImage(named:"videoScreenshot03")!, source: "Vine "),
        VideoInfo(title: "Adventure Time", image: UIImage(named:"videoScreenshot04")!, source: "Youtube"),
        VideoInfo(title: "Facebook HQ", image: UIImage(named:"videoScreenshot05")!, source: "Facebook"),
        VideoInfo(title: "Lijiang Lugu Lake", image: UIImage(named:"videoScreenshot06")!, source: "Allen")
        ]
    
    
    @IBAction func playVideo() {
        let videoPath = NSBundle.mainBundle().pathForResource("emoji zone", ofType: ".mp4")
        let avvc = AVPlayerViewController()
        let player = AVPlayer(URL: NSURL(fileURLWithPath: videoPath!))
        avvc.player = player
        presentViewController(avvc, animated: true) { 
            player.play()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .BlackTranslucent
        self.title = "Watch Later"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 20)!]
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        let rows = video.count
        return rows
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Video Cell", forIndexPath: indexPath) as? MyTableViewCell
        
        let info = video[indexPath.row]
        
        cell?.imagView.image = info.image
        cell?.imageInfo.text = info.title
        cell?.imageSource.text = info.source
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 200
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
