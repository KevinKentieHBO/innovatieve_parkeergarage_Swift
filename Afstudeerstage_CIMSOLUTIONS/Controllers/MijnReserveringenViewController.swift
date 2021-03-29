//
//  MijnReserveringenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 29/03/2021.
//

import UIKit

class MijnReserveringenViewController: UIViewController {

    @IBOutlet weak var ParkeergarageDatumCell: UILabel!
    @IBOutlet weak var ParkeergarageNaamCell: UILabel!
    @IBOutlet weak var MijnReserveringenTable: UITableView!
    
    private var data: [InfoReservering] = []
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "MijnReserveringenTableViewCell", bundle: nil)
        MijnReserveringenTable.register(nib, forCellReuseIdentifier: "MijnReserveringenTableViewCell")
        self.MijnReserveringenTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        getReserveringenVanGebruiker { (array) in
            DispatchQueue.main.async {
            self.data = array
            self.MijnReserveringenTable.reloadData()
        }
    }
        super.viewDidLoad()
        MijnReserveringenTable.delegate = self
        MijnReserveringenTable.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
    
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

extension MijnReserveringenViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MijnReserveringenTableViewCell",
                                                 for: indexPath) as! MijnReserveringenTableViewCell
        cell.CellDatum.text = data[indexPath.row].reservering_Datum
        cell.CellTijd.text = data[indexPath.row].reservering_Begintijd
        cell.CellParkeergarage.text = data[indexPath.row].reservering_Parkeergarage
        //cell.textLabel?.text = data[indexPath.row].reservering_Datum
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
