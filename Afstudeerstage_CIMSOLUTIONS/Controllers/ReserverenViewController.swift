//
//  ReserverenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 26/03/2021.
//

import UIKit
import Foundation

class ReserverenViewController: UIViewController {
    @IBOutlet weak var parkeerGarageLabel: UILabel!
    @IBOutlet weak var LocatieLabel: UILabel!
    @IBOutlet weak var ParkeerplekkenLabel: UILabel!
    @IBOutlet weak var OpeningstijdLabel: UILabel!
    @IBOutlet weak var ReserveerButton: UIButton!
    @IBOutlet weak var DatumTxT: UITextField!
    @IBOutlet weak var EindTijdTxT: UITextField!
    
    //lege parkeergarage object
    var parkeergarageGekozen = Parkeergarage(parkeergarage_Id: 0,parkeergarage_Naam: "",parkeergarage_Locatie: "",parkeergarage_Parkeerlagen: 0,parkeergarage_Aantal_Plaatsen: 0,parkeergarage_Opening: "",parkeergarage_Sluiting: "")
    
    //initializeer dataPicker
    let datePicker = UIDatePicker()
    let datePickerEind = UIDatePicker()
    
    //Wanneer pagina geladen wordt
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
    
    //Aanmaken van de DatePicker
    func createDataPicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        DatumTxT.inputAccessoryView = toolbar
        datePicker.locale = NSLocale(localeIdentifier: "nl") as Locale
        datePicker.minimumDate = Date()
        //datePicker.minuteInterval = 5
        DatumTxT.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
    }
    
    //Aanmaken van de done button
    @objc func donePressed(){
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        formatter.locale = NSLocale(localeIdentifier: "nl") as Locale
        DatumTxT.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        EindTijdTxT.text = nil
        createDataPickerEind()
    }
    
    //Aanmaken van de DatePicker
    func createDataPickerEind(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedEind))
        toolbar.setItems([doneBtn], animated: true)
        EindTijdTxT.inputAccessoryView = toolbar
        datePickerEind.locale = NSLocale(localeIdentifier: "nl") as Locale
        datePickerEind.minimumDate = datePicker.date
        //datePickerEind.minuteInterval = 5
        EindTijdTxT.inputView = datePickerEind
        datePickerEind.datePickerMode = .time
    }
    
    //Aanmaken van de done button
    @objc func donePressedEind(){
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        formatter.locale = NSLocale(localeIdentifier: "nl") as Locale
        EindTijdTxT.text = formatter.string(from: datePickerEind.date)
        self.view.endEditing(true)
    }
    
    @IBAction func maakReservering(_ sender: Any) {
        let tijdFormatter = DateFormatter()
        let datumFormatter = DateFormatter()
        tijdFormatter.dateFormat = "HH:mm"
        datumFormatter.dateFormat = "dd-MM-yyyy"
        let gereserveerdeTijd = tijdFormatter.string(from: datePicker.date)
        let gereserveerdeTijdEind = tijdFormatter.string(from: datePickerEind.date)
        let gereserveerdeDatum = datumFormatter.string(from: datePicker.date)
        print(gereserveerdeDatum)
        print(gereserveerdeTijd)
        
        let res = makeReservering(reservering_Begintijd: gereserveerdeTijd, reservering_Eindtijd: gereserveerdeTijdEind, reservering_Datum: gereserveerdeDatum, reservering_Auto_Id: 1)
        
        createReservering(res: res)
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
