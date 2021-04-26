//
//  KentekenToevoegenViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 15/04/2021.
//

import UIKit

class KentekenToevoegenViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var toevoegenKnop: UIButton!
    @IBOutlet weak var kentekenInvoeren: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kentekenInvoeren.font =  UIFont.init(name: (kentekenInvoeren.font?.fontName)!, size: 35.0)
        kentekenInvoeren.delegate = self
    }
    
    @IBAction func voegKentekenToe(_ sender: Any) {
        toevoegenAuto(kenteken: kentekenInvoeren.text!){(res) in
            DispatchQueue.main.async {
                if res.resultaat == "true"{
                    self.createAlert(title: "Kenteken toegevoegd" , message: "De zojuist ingevoerde kenteken is toegevoegd",resultaat: "true")
                }else{
                    self.createAlert(title: "Error", message: "De zojuist ingevoerde kenteken is niet toegevoegd",resultaat: "false")
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-").isSuperset(of: CharacterSet(charactersIn: string)) && range.location < 8 else {
            return false
        }
        return true
    }
    
    //Aanmaken van een alert om de error te tonen aan de gebruiker
    func createAlert(title: String, message: String, resultaat : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            if resultaat == "true"{
                self.verwijsScherm()
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //verwijst naar het de kentekenview
    func verwijsScherm(){
        _ = navigationController?.popViewController(animated: true)
    }
}
