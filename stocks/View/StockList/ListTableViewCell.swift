//
//  ListTableViewCell.swift
//  stocks
//
//  Created by 홍태희 on 2022/05/12.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var images: UIImageView?
    @IBOutlet weak var company: UILabel?
    @IBOutlet weak var present: UILabel?
    @IBOutlet weak var presentmoney: UILabel?
    @IBOutlet weak var predicts: UILabel?
    @IBOutlet weak var deal: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
