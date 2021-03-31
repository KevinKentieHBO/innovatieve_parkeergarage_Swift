//
//  MijnReserveringenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 29/03/2021.
//

import UIKit

class MijnReserveringenViewController: UIViewController {

    //Initializeren van de verschillende interface attributen
    @IBOutlet weak var ParkeergarageDatumCell: UILabel!
    @IBOutlet weak var ParkeergarageNaamCell: UILabel!
    @IBOutlet weak var MijnReserveringenTable: UITableView!
    
    //lege lijst met Reserveringen van de gebruiker
    private var data: [InfoReservering] = []
    var refreshControl = UIRefreshControl()
    
    //wanneer de pagina geladen wordt
    override func viewDidLoad() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        MijnReserveringenTable.addSubview(refreshControl)
        
        //zet de styling binnen een cel
        let nib = UINib(nibName: "MijnReserveringenTableViewCell", bundle: nil)
        MijnReserveringenTable.register(nib, forCellReuseIdentifier: "MijnReserveringenTableViewCell")
        self.MijnReserveringenTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //Haal de reserveringen van de gebruiker op en zet deze in de lijst
        getReserveringenVanGebruiker { (array) in
            DispatchQueue.main.async {
            self.data = array
            self.MijnReserveringenTable.reloadData()
        }
    }
        super.viewDidLoad()
        
        //Zet de tabel in de interface
        MijnReserveringenTable.delegate = self
        MijnReserveringenTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.viewDidLoad()
        self.refreshControl.endRefreshing();
    }
}

//Zet de tabel in de storyboard
extension MijnReserveringenViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let reservering = data[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "infoReserverenVCIdentifier") as! InfoReserveringViewController
        newVC.gekozenReservering = reservering
        self.show(newVC, sender: self)
    }
}

//Data in de cellen zetten
extension MijnReserveringenViewController: UITableViewDataSource{
    //toon x aantal cellen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //zet de data in de cellen.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MijnReserveringenTableViewCell",
                                                 for: indexPath) as! MijnReserveringenTableViewCell
        cell.CellDatum.text = data[indexPath.row].reservering_Datum
        cell.CellTijd.text = data[indexPath.row].reservering_Begintijd
        cell.CellParkeergarage.text = data[indexPath.row].reservering_Parkeergarage
        return cell
    }
}
