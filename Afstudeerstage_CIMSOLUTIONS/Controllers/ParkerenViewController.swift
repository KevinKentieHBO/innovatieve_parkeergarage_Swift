//
//  ParkerenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 24/03/2021.
//

import UIKit

//Controller voor het regelen van de lijst met parkeergarages
class ParkerenViewController: UIViewController {
    
    //maken van een lege cel tabel
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    //lege lijst van parkeergarages
    private var data: [Parkeergarage] = []

    //wanneer pagina geladen wordt
    override func viewDidLoad() {
        //Ophalen van alle parkeergarages en deze in de lege parkeergarage lijst toevoegen
            getAllParkeergarages { (array) in
                DispatchQueue.main.async {
                self.data = array
                self.tableView.reloadData()
            }
        }
        super.viewDidLoad()
        
        //toevoegen van de tabel aan het canvas
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

//Extentie van de parkeerviewController die de tabel in het canvas plaatst
extension ParkerenViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let parkeergarage = data[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "reserverenVCIdentifier") as! ReserverenViewController
        newVC.parkeergarageGekozen = parkeergarage
        self.show(newVC, sender: self)
    }
}

//Inleden van de cellen en opzetten van de inner cell
extension ParkerenViewController: UITableViewDataSource{
    //laat x aantal cellen tonen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //Zet de data in de cel
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].parkeergarage_Naam
        return cell
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
