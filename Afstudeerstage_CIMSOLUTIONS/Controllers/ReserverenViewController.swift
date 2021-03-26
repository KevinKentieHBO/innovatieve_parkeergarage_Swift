//
//  ReserverenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 26/03/2021.
//

import UIKit

class ReserverenViewController: UIViewController {
    @IBOutlet weak var parkeerGarageLabel: UILabel!
    @IBOutlet weak var LocatieLabel: UILabel!
    @IBOutlet weak var ParkeerplekkenLabel: UILabel!
    @IBOutlet weak var OpeningstijdLabel: UILabel!
    @IBOutlet weak var ReserveerButton: UIButton!
    @IBOutlet weak var DatumTxT: UITextField!
    
    var parkeergarageGekozen = Parkeergarage(parkeergarage_Id: 0,parkeergarage_Naam: "",parkeergarage_Locatie: "",parkeergarage_Parkeerlagen: 0,parkeergarage_Aantal_Plaatsen: 0,parkeergarage_Opening: "",parkeergarage_Sluiting: "")
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parkeerGarageLabel.text = parkeergarageGekozen.parkeergarage_Naam
        LocatieLabel.text = parkeergarageGekozen.parkeergarage_Locatie
        ParkeerplekkenLabel.text = String(parkeergarageGekozen.parkeergarage_Aantal_Plaatsen)
        OpeningstijdLabel.text = parkeergarageGekozen.parkeergarage_Opening + " - " + parkeergarageGekozen.parkeergarage_Sluiting
        ReserveerButton.layer.cornerRadius = 4
        createDataPicker()
        // Do any additional setup after loading the view.
    }
    
    func createDataPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        DatumTxT.inputAccessoryView = toolbar
        datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        DatumTxT.inputView = datePicker
        
        datePicker.datePickerMode = .dateAndTime
    }
    
    @objc func donePressed(){
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        DatumTxT.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
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
