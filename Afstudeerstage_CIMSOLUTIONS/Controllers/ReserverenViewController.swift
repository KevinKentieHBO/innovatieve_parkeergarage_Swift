//
//  ReserverenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 26/03/2021.
//

import UIKit
import Foundation

//Deze klassen dient als controller voor de pagina waar de gebruiker zijn reservering
class ReserverenViewController: UIViewController {
    
    
//Interface Items
    @IBOutlet weak var parkeerGarageLabel: UILabel!
    @IBOutlet weak var LocatieLabel: UILabel!
    @IBOutlet weak var ParkeerplekkenLabel: UILabel!
    @IBOutlet weak var OpeningstijdLabel: UILabel!
    @IBOutlet weak var ReserveerButton: UIButton!
    @IBOutlet weak var DatumTxT: UITextField!
    @IBOutlet weak var EindTijdTxT: UITextField!
    
    
//Variabelen
    //leeg parkeergarage object
    var parkeergarageGekozen = Parkeergarage(parkeergarage_Id: 0,parkeergarage_Naam: "",parkeergarage_Locatie: "",parkeergarage_Parkeerlagen: 0,parkeergarage_Aantal_Plaatsen: 0,parkeergarage_Opening: "",parkeergarage_Sluiting: "")
    
    //initializeer dataPicker voor begintijd en eindtijd
    let datePicker = UIDatePicker()
    let datePickerEind = UIDatePicker()
    
    
//Functies
    //Wanneer pagina geladen wordt
    override func viewDidLoad() {
        super.viewDidLoad()
        //zet de tekstvelden klaar
        parkeerGarageLabel.text = parkeergarageGekozen.parkeergarage_Naam
        LocatieLabel.text = parkeergarageGekozen.parkeergarage_Locatie
        ParkeerplekkenLabel.text = String(parkeergarageGekozen.parkeergarage_Aantal_Plaatsen)
        OpeningstijdLabel.text = parkeergarageGekozen.parkeergarage_Opening + " - " + parkeergarageGekozen.parkeergarage_Sluiting
        ReserveerButton.layer.cornerRadius = 4
        EindTijdTxT.text = nil
        DatumTxT.text = nil
        
        //Zet het invoerveld voor de eindtijd uit
        EindTijdTxT.isEnabled = false
        
        //initializeert de datePickers
        createDataPicker()
        createDataPickerEind()
    }
    
    //Aanmaken van de DatePicker
    func createDataPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //aanmaken van een Done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        //Styling datepicker begintijd
        DatumTxT.inputAccessoryView = toolbar
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "nl") as Locale
        datePicker.minimumDate = Date()
        DatumTxT.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
    }
    
    //Aanmaken van de done button
    @objc func donePressed(){
        //formatter voor het tekstveld van de begintijd
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        formatter.locale = NSLocale(localeIdentifier: "nl") as Locale
        
        //check of de tijden niet buiten de uitrij tijden staan
        datePickerChanged()
        
        //Datum neerzetten in het tijdsvak
        DatumTxT.text = formatter.string(from: datePicker.date)
        
        //toolbar deactiveren
        self.view.endEditing(true)
        
        //Aanzetten invoerveld eindtijd
        EindTijdTxT.text = nil
        EindTijdTxT.isEnabled = true
        EindTijdTxT.backgroundColor = .white
        createDataPickerEind()
    }
    
    //Aanmaken van de DatePicker voor de eindtijd
    func createDataPickerEind(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //aanmaken van een Done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedEind))
        toolbar.setItems([doneBtn], animated: true)
        
        //Styling datepicker begintijd
        EindTijdTxT.inputAccessoryView = toolbar
        datePickerEind.preferredDatePickerStyle = .wheels
        datePickerEind.locale = NSLocale(localeIdentifier: "nl") as Locale
        datePickerEind.minimumDate = datePicker.date
        //datePickerEind.minuteInterval = 5
        EindTijdTxT.inputView = datePickerEind
        datePickerEind.datePickerMode = .time
    }
    
    //Aanmaken van de done button
    @objc func donePressedEind(){
        //formatter voor het tekstveld van de eindtijd
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        formatter.locale = NSLocale(localeIdentifier: "nl") as Locale
        
        //Datum neerzetten in het tijdsvak
        EindTijdTxT.text = formatter.string(from: datePickerEind.date)
        
        //toolbar deactiveren
        self.view.endEditing(true)
    }
    
    //Voert een create methode uit op de reservering wanneer de invoervelden niet leeg zijn
    @IBAction func maakReservering(_ sender: Any) {
        //als een of beide velden leeg zijn
        if DatumTxT.text == "" || EindTijdTxT.text == ""{
            //Opzetten van een error alert
            creareAlert(title: "Error", message: "Vul de invoervelden in voor het bevestigen van de reservering")
        }else{
            //Formatter voor het wegzetten van de data
            let tijdFormatter = DateFormatter()
            let datumFormatter = DateFormatter()
            tijdFormatter.dateFormat = "HH:mm"
            datumFormatter.dateFormat = "dd-MM-yyyy"
            let gereserveerdeTijd = tijdFormatter.string(from: datePicker.date)
            let gereserveerdeTijdEind = tijdFormatter.string(from: datePickerEind.date)
            let gereserveerdeDatum = datumFormatter.string(from: datePicker.date)

            //functie die de reservering naar de database voert.
            let res = makeReservering(reservering_Begintijd: gereserveerdeTijd, reservering_Eindtijd: gereserveerdeTijdEind, reservering_Datum: gereserveerdeDatum, reservering_Auto_Id:  UserDefaults.standard.integer(forKey: "Actief_Kenteken_Id"), reservering_Parkeergarage_Id: parkeergarageGekozen.parkeergarage_Id)
                createReservering(res: res)
            
            //Wacht tot reservering is doorgevoerd
            sleep(1);
            
            //Navigeer naar de zojuist gemaakte reservering
            getZojuistGemaakteReservering(datum: gereserveerdeDatum, begintijd: gereserveerdeTijd, eindtijd: gereserveerdeTijdEind, parkeergarageid: parkeergarageGekozen.parkeergarage_Id){(array) in
                DispatchQueue.main.async {
                    self.verwijsNaarInfo(res: array)
                }
            }
        }
    }
    
    //Aanmaken van een alert om de error te tonen aan de gebruiker
    func creareAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //controleren of de tijdsblokken niet buiten de inrijtijden vallen
    func datePickerChanged() {
        //formatter initializeren
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = NSLocale(localeIdentifier: "nl") as Locale
        
        //in en uitrij tijd constateren van de parkeergarage
        let begintijd = formatter.date(from: parkeergarageGekozen.parkeergarage_Opening)
        let eindtijd = formatter.date(from: parkeergarageGekozen.parkeergarage_Sluiting)
        
        //omzetten gekozen tijd naar Calendar
        var components = Calendar.current.dateComponents([.hour, .minute, .month, .year, .day], from: datePicker.date)
        let opening = Calendar.current.dateComponents([.hour, .minute], from: begintijd!)
        let sluiting = Calendar.current.dateComponents([.hour, .minute], from: eindtijd!)
        
        //als begintijd onder inrij tijd is
        if components.hour! < opening.hour! {
            components.hour = opening.hour!
            components.minute = opening.minute!
            //zet tijd naar inrij tijd
            datePicker.setDate(Calendar.current.date(from: components)!, animated: true)
        }
        //als eindtijd boven uitrij tijd is
        else if components.hour! >= sluiting.hour! && components.minute! > sluiting.minute! {
            components.hour = sluiting.hour!
            components.minute = sluiting.minute!
            //zet tijd naar uitrij tijd
            datePicker.setDate(Calendar.current.date(from: components)!, animated: true)
        }
    }
    
    func verwijsNaarInfo(res : InfoReservering){
        let reservering = res
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "infoReserverenVCIdentifier") as! InfoReserveringViewController
        newVC.gekozenReservering = reservering
        newVC.nieuweReservering = true
        self.show(newVC, sender: self)
    }
    
    @IBAction func verwijsNaarAbonnementen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "abonnementParkeergarageId") as! AbonnementParkeergarageViewController
        newVC.parkeergarageGekozen = self.parkeergarageGekozen
        self.show(newVC, sender: self)
    }
    
}
