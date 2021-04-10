//
//  GegevensViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 24/03/2021.
//

import UIKit

//Controller voor de pagina waar de gegevens van de gebruiker getoont worden
class GegevensViewController: UIViewController {

    
//Interface Items
    @IBOutlet weak var MijnReserveringen: UIButton!
    
    
//Functies
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logUit(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
}
