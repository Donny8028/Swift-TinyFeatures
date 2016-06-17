//
//  MovieDetailsViewController.swift
//  SpotIt
//
//  Created by Gabriel Theodoropoulos on 11/11/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imgMovieImage: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblDirector: UILabel!
    
    @IBOutlet weak var lblStars: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    
    var movie: [String:String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        lblRating.layer.cornerRadius = lblRating.frame.size.width/2
        lblRating.layer.masksToBounds = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setView() {
        imgMovieImage?.image = UIImage(named: movie!["Image"]!)
        lblTitle?.text = movie!["Title"]
        lblCategory?.text = movie!["Category"]
        lblDescription?.text = movie!["Description"]
        lblDirector?.text = movie!["Director"]
        lblStars?.text = movie!["Stars"]
        lblRating?.text = movie!["Rating"]
    }
}
