//
//  MijnReserveringenTableViewCell.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 29/03/2021.
//

import UIKit

//Controller voor een enkele cell van een tabel
class MijnReserveringenTableViewCell: UITableViewCell {

    
    @IBOutlet weak var CellParkeergarage: UILabel!
    @IBOutlet weak var CellDatum: UILabel!
    @IBOutlet weak var CellTijd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
