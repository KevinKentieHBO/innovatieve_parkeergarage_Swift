//
//  InfoReserveringViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 29/03/2021.
//

import UIKit

class InfoReserveringViewController: UIViewController {
    
    
    @IBOutlet weak var TitelInfoReservering: UILabel!
    @IBOutlet weak var BegintijdReservering: UILabel!
    @IBOutlet weak var DatumReservering: UILabel!
    @IBOutlet weak var EindtijdReservering: UILabel!
    @IBOutlet weak var ParkeergarageReservering: UILabel!
    @IBOutlet weak var LocatieReservering: UILabel!
    @IBOutlet weak var ParkeerplaatsReservering: UILabel!
    
    var gekozenReservering = InfoReservering(reservering_Id: 0, reservering_Parkeerplaats_Id: 0, reservering_Begintijd: "", reservering_Eindtijd: "", reservering_Datum: "", reservering_Parkeerplaats_laag: 0, reservering_Parkeerplaats_plek: 0, reservering_Parkeergarage: "", reservering_ParkeergarageLocatie: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        TitelInfoReservering.text = gekozenReservering.reservering_Datum
        BegintijdReservering.text = gekozenReservering.reservering_Begintijd
        EindtijdReservering.text = gekozenReservering.reservering_Eindtijd
        DatumReservering.text = gekozenReservering.reservering_Datum
        LocatieReservering.text = gekozenReservering.reservering_ParkeergarageLocatie
        ParkeergarageReservering.text = gekozenReservering.reservering_Parkeergarage
        ParkeerplaatsReservering.text = String(gekozenReservering.reservering_Parkeerplaats_laag)+"-"+String(gekozenReservering.reservering_Parkeerplaats_plek)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
