//
//  MijnReserveringenTableViewCell.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 29/03/2021.
//

import UIKit

class MijnReserveringenTableViewCell: UITableViewCell {

    
    @IBOutlet weak var CellParkeergarage: UILabel!
    @IBOutlet weak var CellDatum: UILabel!
    @IBOutlet weak var CellTijd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
