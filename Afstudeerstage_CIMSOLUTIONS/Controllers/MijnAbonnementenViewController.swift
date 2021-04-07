//
//  MijnAbonnementenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 07/04/2021.
//

import UIKit

class MijnAbonnementenViewController: UIViewController {

//Interface Items
    //Initializeren van de verschillende interface attributen
    @IBOutlet weak var mijnAbonnementenTabel: UITableView!
    
//Variabelen
    //lege lijst met Abonnementen van de gebruiker
    private var data: [AbonnementGebruiker] = []
    
    override func viewDidLoad() {
        
        //zet de styling binnen een cel
        let nib = UINib(nibName: "MijnAbonnementenTableViewCell", bundle: nil)
        mijnAbonnementenTabel.register(nib, forCellReuseIdentifier: "MijnAbonnementenTableViewCell")
        self.mijnAbonnementenTabel.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        //Haal de abonnementen van de gebruiker op en zet deze in de lijst
        getAbonnementAutoId{(array) in
            DispatchQueue.main.async {
                self.data = array
                self.mijnAbonnementenTabel.reloadData()
            }
        }
        
        super.viewDidLoad()
        
        mijnAbonnementenTabel.delegate = self
        mijnAbonnementenTabel.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

extension MijnAbonnementenViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MijnAbonnementenViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MijnAbonnementenTableViewCell",
                                                 for: indexPath) as! MijnAbonnementenTableViewCell
        cell.abonnementTypeLabel.text = data[indexPath.row].abonnement_Type
        cell.parkeergarageNaamLabel.text = data[indexPath.row].parkeergarage_Naam
        cell.beschrijvingLabel.text = data[indexPath.row].abonnement_Beschrijving
        cell.eindDatumLabel.text = data[indexPath.row].abonnement_Einddatum
        cell.statusLabel.text = data[indexPath.row].abonnement_Status
        return cell
    }
    
    
}
