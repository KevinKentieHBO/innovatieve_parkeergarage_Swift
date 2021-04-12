//
//  GegevensViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 24/03/2021.
//

import UIKit

//Controller voor de pagina waar de gegevens van de gebruiker getoont worden
class GegevensViewController: UIViewController {
    @IBOutlet weak var saldoLabel: UILabel!
    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var geboortedatumLabel: UILabel!
    
//Interface Items
    @IBOutlet weak var MijnReserveringen: UIButton!
    
    
//Functies
    override func viewDidLoad() {
        super.viewDidLoad()
        naamLabel.text = UserDefaults.standard.string(forKey: "Bestuurder_Naam")
        
        getUserData{(data) in
            DispatchQueue.main.async {
                self.emailLabel.text = data.Account_Email
                self.geboortedatumLabel.text = data.Bestuurder_Geboortedatum
                self.saldoLabel.text = String(format: "€%.2f", data.Account_Saldo)
            }
        }

    }
    
    @IBAction func logUit(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
}
