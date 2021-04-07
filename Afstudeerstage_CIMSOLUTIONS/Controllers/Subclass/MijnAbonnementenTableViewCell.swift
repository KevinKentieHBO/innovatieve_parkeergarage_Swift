//
//  MijnAbonnementenTableViewCell.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 07/04/2021.
//

import UIKit

class MijnAbonnementenTableViewCell: UITableViewCell {

    @IBOutlet weak var parkeergarageNaamLabel: UILabel!
    @IBOutlet weak var abonnementTypeLabel: UILabel!
    @IBOutlet weak var beschrijvingLabel: UILabel!
    @IBOutlet weak var eindDatumLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
