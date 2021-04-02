//
//  InfoReserveringViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 29/03/2021.
//

import UIKit

//Controller voor het geregelen van de info van een individuele reservering
class InfoReserveringViewController: UIViewController {
  
    
//Interface Items
    //opzetten van de interface attributen
    @IBOutlet weak var TitelInfoReservering: UILabel!
    @IBOutlet weak var BegintijdReservering: UILabel!
    @IBOutlet weak var DatumReservering: UILabel!
    @IBOutlet weak var EindtijdReservering: UILabel!
    @IBOutlet weak var ParkeergarageReservering: UILabel!
    @IBOutlet weak var LocatieReservering: UILabel!
    @IBOutlet weak var ParkeerplaatsReservering: UILabel!
    //opzetten van de interface buttons
    @IBOutlet weak var WijzigenButton: UIButton!
    @IBOutlet weak var VerwijderenButton: UIButton!
    
    
//Variabelen
    //Lege reservering om uiteindelijk de gekozen reservering in te zetten.
    var gekozenReservering = InfoReservering(reservering_Id: 0, reservering_Parkeerplaats_Id: 0, reservering_Begintijd: "", reservering_Eindtijd: "", reservering_Datum: "", reservering_Parkeerplaats_laag: 0, reservering_Parkeerplaats_plek: 0, reservering_Parkeergarage: "", reservering_ParkeergarageLocatie: "", reservering_Parkeergarage_Opening: "",reservering_Parkeergarage_Sluiting: "", reservering_parkeergarage_Id: 0)
    var nieuweReservering : Bool = false

    
//Functies
    //Wanneer pagina geladen wordt
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WijzigenButton.layer.cornerRadius = 4
        VerwijderenButton.layer.cornerRadius = 4
        
        if(nieuweReservering){
            self.navigationItem.hidesBackButton = true
            let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(InfoReserveringViewController.goToHome(_:)))
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
    
    @IBAction func goToHome(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    
    //Navigeren naar het wijzigen van een reservering
    
    @IBAction func wijzigReservering(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let wijzigReserveringViewController = storyBoard.instantiateViewController(withIdentifier: "wijzigViewControllerId") as! WijzigReserverenViewController
        wijzigReserveringViewController.teWijzigenReservering = gekozenReservering
        self.show(wijzigReserveringViewController, sender: self)
    }
    
    
    //Alert aanroepen om reservering te verwijderen
    @IBAction func verwijderReservering(_ sender: Any){
        createAlertReserveringVerwijderen(title: "Reservering verwijderen", message: "Weet u zeker dat u deze reservering wilt verwijderen?")
    }
    
    //Aanmaken van een alert om te conformeren dat een reservering wordt verwijderd
    func createAlertReserveringVerwijderen(title: String, message: String)
    {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //Gebruiker de mogelijkheid bieden om de reservering te verwijderen of niet
        alert.addAction(UIAlertAction(title: "Ja", style: .default, handler: {(action) in
            //Als ja wordt geklikt zal er een response opgehaald worden met conformatie of de reservering verwijderd is.
            verwijderReserveringRest(res: self.gekozenReservering){(array) in
                DispatchQueue.main.async {
                    if array.resultaat == "false"{
                        self.conformeerAlertReserveringVerwijderen(title: "Reservering niet verwijderd", message: "De reservering is niet verwijderd omdat de reservering voorbij is.")
                    }else if array.resultaat == "true"{
                        self.conformeerAlertReserveringVerwijderen(title: "Reservering verwijderd", message: "De reservering is verwijderd.")
                    }
                }
            }
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Nee", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    //Aanmaken van een alert om de gebruiker op de hoogte te stellen dat de reservering verwijderd is.
    func conformeerAlertReserveringVerwijderen(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            if(self.tabBarController?.selectedIndex != 0){
                self.tabBarController?.selectedIndex = 0
            }else{
                self.navigationController?.popToRootViewController(animated: false)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
