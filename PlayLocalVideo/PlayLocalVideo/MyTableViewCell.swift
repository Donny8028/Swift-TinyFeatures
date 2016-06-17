//
//  MyTableViewCell.swift
//  PlayLocalVideo
//
//  Created by 賢瑭 何 on 2016/5/12.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit

struct VideoInfo {
    let title: String
    let image: UIImage
    let source: String
}

class MyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imagView: UIImageView!
    @IBOutlet weak var imageInfo: UILabel!
    @IBOutlet weak var imageSource: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
