//
//  LivesTableViewCell.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/27.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class LivesTableViewCell: UITableViewCell {
    @IBOutlet weak var imgPor: UIImageView!
    @IBOutlet weak var labelNick: UILabel!
    @IBOutlet weak var livAddr: UILabel!
    @IBOutlet weak var labelViewers: UILabel!
    @IBOutlet weak var imgBigPor: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
