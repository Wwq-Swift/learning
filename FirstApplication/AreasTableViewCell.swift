//
//  AreasTableViewCell.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/16.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class AreasTableViewCell: UITableViewCell {
    @IBOutlet weak var direction: UILabel!
    @IBOutlet weak var areaName: UILabel!
    @IBOutlet weak var areaDescribe: UILabel!
    @IBOutlet weak var areaImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
