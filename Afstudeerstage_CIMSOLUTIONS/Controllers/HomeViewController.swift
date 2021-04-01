//
//  ViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 24/03/2021.
//

import UIKit

//Controller voor het aansturen van de homepagina
class HomeViewController: UIViewController, UITabBarDelegate, UITabBarControllerDelegate {
    
    //Connectie met de TableView uit de storyboard
    @IBOutlet weak var HomeReserveringenTabel: UITableView!
    
    //lege lijst met reserveringen
    private var data: [InfoReservering] = []

    override func viewDidLoad() {
        
        //zet de styling binnen een cel
        let nib = UINib(nibName: "MijnReserveringenTableViewCell", bundle: nil)
        HomeReserveringenTabel.register(nib, forCellReuseIdentifier: "MijnReserveringenTableViewCell")
        self.HomeReserveringenTabel.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //Haal de reserveringen van de gebruiker op en zet deze in de lijst
        getReserveringenVanGebruiker { (array) in
            DispatchQueue.main.async {
            self.data = array
            self.HomeReserveringenTabel.reloadData()
            }
        }
        
        super.viewDidLoad()
        
        //Zet de tabel in de interface
        HomeReserveringenTabel.delegate = self
        HomeReserveringenTabel.dataSource = self
        
        //Stemt de tab bar af
        tabBarController?.delegate = self
    }
    
    //Zorgt ervoor dat bij het tab parkeren altijd naar de root wordt genavigeert.
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            // im my example the desired view controller is the second one
            // it might be different in your case...
            let secondVC = tabBarController.viewControllers?[1] as! UINavigationController
            secondVC.popToRootViewController(animated: false)
        }
}

//Zet de tabel in de storyboard
extension HomeViewController: UITableViewDelegate{
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
extension HomeViewController: UITableViewDataSource{
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

