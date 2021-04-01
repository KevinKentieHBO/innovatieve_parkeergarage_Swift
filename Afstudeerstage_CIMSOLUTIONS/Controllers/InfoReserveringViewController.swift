//
//  InfoReserveringViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 29/03/2021.
//

import UIKit

//Controller voor het geregelen van de info van een individuele reservering
class InfoReserveringViewController: UIViewController {
    
    //opzetten van de interface attributen
    @IBOutlet weak var TitelInfoReservering: UILabel!
    @IBOutlet weak var BegintijdReservering: UILabel!
    @IBOutlet weak var DatumReservering: UILabel!
    @IBOutlet weak var EindtijdReservering: UILabel!
    @IBOutlet weak var ParkeergarageReservering: UILabel!
    @IBOutlet weak var LocatieReservering: UILabel!
    @IBOutlet weak var ParkeerplaatsReservering: UILabel!
    
    //Lege reservering om uiteindelijk de gekozen reservering in te zetten.
    var gekozenReservering = InfoReservering(reservering_Id: 0, reservering_Parkeerplaats_Id: 0, reservering_Begintijd: "", reservering_Eindtijd: "", reservering_Datum: "", reservering_Parkeerplaats_laag: 0, reservering_Parkeerplaats_plek: 0, reservering_Parkeergarage: "", reservering_ParkeergarageLocatie: "")
    var nieuweReservering : Bool = false

    //Wanneer pagina geladen wordt
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(nieuweReservering){
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(InfoReserveringViewController.goToSecond(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        }
        
        //zet alle interface attributen
        TitelInfoReservering.text = gekozenReservering.reservering_Datum
        BegintijdReservering.text = gekozenReservering.reservering_Begintijd
        EindtijdReservering.text = gekozenReservering.reservering_Eindtijd
        DatumReservering.text = gekozenReservering.reservering_Datum
        LocatieReservering.text = gekozenReservering.reservering_ParkeergarageLocatie
        ParkeergarageReservering.text = gekozenReservering.reservering_Parkeergarage
        ParkeerplaatsReservering.text = String(gekozenReservering.reservering_Parkeerplaats_laag)+"-"+String(gekozenReservering.reservering_Parkeerplaats_plek)
    }
    
    @IBAction func goToSecond(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
}
