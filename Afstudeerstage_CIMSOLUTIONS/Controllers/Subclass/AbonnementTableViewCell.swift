//
//  AbonnementTableViewCell.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 06/04/2021.
//

import UIKit

class AbonnementTableViewCell: UITableViewCell {

    @IBOutlet weak var typeAbonnement: UILabel!
    @IBOutlet weak var beschrijvingAbonnement: UILabel!
    @IBOutlet weak var prijsAbonnement: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shadowAndBorderForCell(yourTableViewCell: self)
        self.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension UITableViewCell{
func shadowAndBorderForCell(yourTableViewCell : UITableViewCell){
    // SHADOW AND BORDER FOR CELL
    //yourTableViewCell.contentView.layer.cornerRadius = 5
    yourTableViewCell.contentView.layer.borderWidth = 0.5
    yourTableViewCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
    yourTableViewCell.contentView.layer.masksToBounds = true
    yourTableViewCell.layer.shadowColor = UIColor.gray.cgColor
    yourTableViewCell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    yourTableViewCell.layer.shadowRadius = 2.0
    yourTableViewCell.layer.shadowOpacity = 1.0
    yourTableViewCell.layer.masksToBounds = false
    yourTableViewCell.layer.shadowPath = UIBezierPath(roundedRect:yourTableViewCell.bounds, cornerRadius:yourTableViewCell.contentView.layer.cornerRadius).cgPath
}
}
