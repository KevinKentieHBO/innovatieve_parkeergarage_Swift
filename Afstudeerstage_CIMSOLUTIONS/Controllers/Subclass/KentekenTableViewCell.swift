//
//  KentekenTableViewCell.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 15/04/2021.
//

import UIKit

class KentekenTableViewCell: UITableViewCell {

    @IBOutlet weak var kentekenLabel: UILabel!
    @IBOutlet weak var actiefLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
