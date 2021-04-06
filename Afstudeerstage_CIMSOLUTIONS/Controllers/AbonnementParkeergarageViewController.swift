//
//  AbonnementParkeergarageViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 06/04/2021.
//

import UIKit

class AbonnementParkeergarageViewController: UIViewController {

//Interface Items
    //Initializeren van de verschillende interface attributen
    @IBOutlet weak var abonnementTabel: UITableView!
    @IBOutlet weak var aanschafKnop: UIButton!
    @IBOutlet weak var garagenaamLabel: UILabel!
    
//Variabelen
    //lege lijst met Reserveringen van de gebruiker
    private var data: [Abonnement] = []
    //leeg parkeergarage object
    var parkeergarageGekozen = Parkeergarage(parkeergarage_Id: 0,parkeergarage_Naam: "",parkeergarage_Locatie: "",parkeergarage_Parkeerlagen: 0,parkeergarage_Aantal_Plaatsen: 0,parkeergarage_Opening: "",parkeergarage_Sluiting: "")
    
//Functies
    //wanneer de pagina geladen wordt
    override func viewDidLoad() {
        
        //zet styling binnen een cell
        let nib = UINib(nibName: "AbonnementTableViewCell", bundle: nil)
        abonnementTabel.register(nib, forCellReuseIdentifier: "AbonnementTableViewCell")
        self.abonnementTabel.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //Haal alle abonnementen van de parkeergarage op uit de database
        getAbonnementParkeergarage(parkeergarageId: parkeergarageGekozen.parkeergarage_Id ){(array) in
            DispatchQueue.main.async {
                self.data = array
                self.abonnementTabel.reloadData()
            }
        }
        
        //Zet de parkeergarage in de label
        garagenaamLabel.text = parkeergarageGekozen.parkeergarage_Naam
        
        super.viewDidLoad()
        
        //Zet de tabel in de interface
        abonnementTabel.delegate = self
        abonnementTabel.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

//Extenties
//Zet de tabel in de storyboard
extension AbonnementParkeergarageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        let abonnement = data[indexPath.row]
    }
}

//Data in de cellen zetten
extension AbonnementParkeergarageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AbonnementTableViewCell", for: indexPath) as! AbonnementTableViewCell
        cell.typeAbonnement.text = data[indexPath.row].abonnement_Type
        cell.beschrijvingAbonnement.text = data[indexPath.row].abonnement_Beschrijving
        cell.prijsAbonnement.text = String(format: "%.2f",  data[indexPath.row].abonnement_Tarief)
        
        return cell
    }
    
    
}
