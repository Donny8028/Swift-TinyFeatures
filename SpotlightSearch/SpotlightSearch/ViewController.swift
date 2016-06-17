//
//  ViewController.swift
//  SpotlightSearch
//
//  Created by 賢瑭 何 on 2016/5/29.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var movies = []
    var selectRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setSpotlight()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellId, forIndexPath: indexPath) as? MovieSummaryCell
        let info = movies[indexPath.row] as? [String:String]
        cell?.imgMovieImage.image = UIImage(named: info!["Image"]!)
        cell?.lblTitle.text = info!["Title"]
        cell?.lblDescription.text = info!["Description"]
        cell?.lblRating.text = info!["Rating"]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectRow = indexPath.row
        performSegueWithIdentifier(Constants.segueId, sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dataInfo = movies[selectRow!] as? [String:String] {
            if segue.identifier == Constants.segueId {
                if let dv = segue.destinationViewController as? MovieDetailsViewController {
                    dv.movie = dataInfo
                }
            }
        }
    }
    
    
    func configuration() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: Constants.nibName, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: Constants.cellId)
        tableView.rowHeight = 120
        let sourceURL = NSBundle.mainBundle().URLForResource(Constants.dataFile, withExtension: Constants.fileExtention)
        let data = NSArray(contentsOfURL: sourceURL!)
        movies = data!
    }
    
    func setSpotlight() {
        var searchableItems = [CSSearchableItem]()
        
        for i in 0...movies.count-1 {
            let movie = movies[i] as! [String:String]
            let searchableAttribute = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
            let ary = movie["Image"]?.componentsSeparatedByString(".")
            let url = NSBundle.mainBundle().URLForResource(ary![0], withExtension: ary![1])
            
            var keywords = [String]()
            searchableAttribute.title = movie["Title"]
            searchableAttribute.thumbnailURL = url
            searchableAttribute.contentDescription = movie["Description"]
            
            let stars = movie["Stars"]?.componentsSeparatedByString(",")
            let category = movie["Category"]?.componentsSeparatedByString(",")
            keywords = stars! + category!
            
            if !keywords.isEmpty {
                searchableAttribute.keywords = keywords
            }
            
            let searchableItem = CSSearchableItem(uniqueIdentifier: "movie.number.at.\(i)", domainIdentifier: "movies", attributeSet: searchableAttribute)
            searchableItems.append(searchableItem)
        }
        if searchableItems.count == movies.count {
            CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(searchableItems, completionHandler: { error in
                if error != nil {
                print("\(error?.localizedDescription)")
                }
            })
        }
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        if activity.activityType == CSSearchableItemActionType{
            if let userInfo = activity.userInfo {
                let activityId = userInfo[CSSearchableItemActivityIdentifier]
                let index = activityId?.componentsSeparatedByString(".")
                selectRow = Int(index!.last!) ?? nil
                if let _ = selectRow {
                    performSegueWithIdentifier(Constants.segueId, sender: self)
                }
            }
        }
    }
    
    struct Constants {
        static let nibName = "MovieSummaryCell"
        static let cellId = "MainCell"
        static let dataFile = "MoviesData"
        static let fileExtention = ".plist"
        static let segueId = "idSegueShowMovieDetails"
    }

}

