//
//  WijzigReserverenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 02/04/2021.
//

import UIKit

class WijzigReserverenViewController: UIViewController {
    
    
//Interface Items
    @IBOutlet weak var beginField: UITextField!
    @IBOutlet weak var eindField: UITextField!
    let datePicker = UIDatePicker()
    let datePickerEind = UIDatePicker()
    

//Variabelen
    //lege reservering om de te wijzigen reservering in op te vangen
    var teWijzigenReservering = InfoReservering(reservering_Id: 0, reservering_Parkeerplaats_Id: 0, reservering_Begintijd: "", reservering_Eindtijd: "", reservering_Datum: "", reservering_Parkeerplaats_laag: 0, reservering_Parkeerplaats_plek: 0, reservering_Parkeergarage: "", reservering_ParkeergarageLocatie: "",reservering_Parkeergarage_Opening: "",reservering_Parkeergarage_Sluiting: "", reservering_parkeergarage_Id: 0)

    
//Funties
    override func viewDidLoad() {
        super.viewDidLoad()
        //Zet het invoerveld voor de eindtijd uit
        eindField.isEnabled = false
        // Do any additional setup after loading the view.
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
        beginField.inputAccessoryView = toolbar
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "nl") as Locale
        datePicker.minimumDate = Date()
        beginField.inputView = datePicker
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
        beginField.text = formatter.string(from: datePicker.date)
        
        //toolbar deactiveren
        self.view.endEditing(true)
        
        //Aanzetten invoerveld eindtijd
        eindField.text = nil
        eindField.isEnabled = true
        eindField.backgroundColor = .white
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
        eindField.inputAccessoryView = toolbar
        datePickerEind.preferredDatePickerStyle = .wheels
        datePickerEind.locale = NSLocale(localeIdentifier: "nl") as Locale
        datePickerEind.minimumDate = datePicker.date
        //datePickerEind.minuteInterval = 5
        eindField.inputView = datePickerEind
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
        eindField.text = formatter.string(from: datePickerEind.date)
        
        //toolbar deactiveren
        self.view.endEditing(true)
    }
    
    //Actie die uitgevoerd wordt wanneer de wijzig knop aangeraakt wordt
    @IBAction func wijzigReservering(_ sender: Any) {
        let tijdFormatter = DateFormatter()
        let datumFormatter = DateFormatter()
        tijdFormatter.dateFormat = "HH:mm"
        datumFormatter.dateFormat = "dd-MM-yyyy"
        let gereserveerdeTijd = tijdFormatter.string(from: datePicker.date)
        let gereserveerdeTijdEind = tijdFormatter.string(from: datePickerEind.date)
        let gereserveerdeDatum = datumFormatter.string(from: datePicker.date)
        
        teWijzigenReservering.reservering_Datum = gereserveerdeDatum
        teWijzigenReservering.reservering_Begintijd = gereserveerdeTijd
        teWijzigenReservering.reservering_Eindtijd = gereserveerdeTijdEind
        updateReserveringRest(res: self.teWijzigenReservering){(array) in
            DispatchQueue.main.async {
                if array.resultaat == "true"{
                    self.creareAlert(title: "Reservering gewijzigd", message: "De reservering is gewijzigd.")
                }else if array.resultaat == "false"{
                    self.creareAlert(title: "Reservering niet gewijzigd", message: "De reservering is niet gewijzigd.")
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
    
    func datePickerChanged() {
        //formatter initializeren
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = NSLocale(localeIdentifier: "nl") as Locale
        
        //in en uitrij tijd constateren van de parkeergarage
        let begintijd = formatter.date(from: teWijzigenReservering.reservering_Parkeergarage_Opening)
        let eindtijd = formatter.date(from: teWijzigenReservering.reservering_Parkeergarage_Sluiting)
        
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
}
