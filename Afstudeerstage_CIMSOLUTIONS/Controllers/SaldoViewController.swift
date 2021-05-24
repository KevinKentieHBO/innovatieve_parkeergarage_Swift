//
//  SaldoViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 24/03/2021.
//

import UIKit

//Controller voor het regelen van de saldo pagina
class SaldoViewController: UIViewController {
   
    @IBOutlet weak var saldoInputField: UITextField!
    @IBOutlet weak var saldoLabel: UILabel!
    
//Functies
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData{(data) in
            DispatchQueue.main.async {
                self.saldoLabel.text = String(format: "€%.2f", data.Account_Saldo)
            }
        }
        saldoInputField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)

    }
    
    @IBAction func Button5(_ sender: Any) {
        saldoInputField.text = "€5.00"
    }
    
    @IBAction func Button10(_ sender: Any) {
        saldoInputField.text = "€10.00"
    }
    
    @IBAction func Button15(_ sender: Any) {
        saldoInputField.text = "€15.00"
    }
    
    @IBAction func Button20(_ sender: Any) {
        saldoInputField.text = "€20.00"
    }
    
    @IBAction func Afrekenen(_ sender: Any) {
        if saldoInputField.text == ""{
            self.createAlert(title: "Error", message: "Vul een saldo in")

        }else{
            let saldofield = saldoInputField.text
            let strippedSaldoField = saldofield?.replacingOccurrences(of: "€", with: "")
            updateSaldo(saldo: strippedSaldoField!){(saldo) in
               DispatchQueue.main.async {
                if saldo.resultaat == "true"{
                    self.createAlert(title: "Succes", message: "Saldo is met \(saldofield!) opgehoogd")
                    self.viewDidLoad()
                }else{
                    self.createAlert(title: "Error", message: "Saldo is met niet opgehoogd")
                    self.viewDidLoad()
                }
               }
            }
            createBetaling(kosten: strippedSaldoField!){(saldo) in
                DispatchQueue.main.async {
                }
            }
        }
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {

        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    //Aanmaken van een alert om de error te tonen aan de gebruiker
    func createAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension String {

    // formatting text for currency textField
    func currencyInputFormatting() -> String {

        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "€"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number)!
    }
}
