//
//  LoginViewController.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 10/04/2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var gebruikersnaamInput: UITextField!
    @IBOutlet weak var wachtwoordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gebruikersnaamInput.delegate = self
        self.wachtwoordInput.delegate = self
    }
    
    
    @IBAction func login(_ sender: Any) {
        if(gebruikersnaamInput.text == "" || wachtwoordInput.text == ""){
            createAlert(title: "Error:", message: "Vul alle velden in.")
        }else{
            checkLogin(gebruikersnaam: gebruikersnaamInput.text!, wachtwoord: wachtwoordInput.text!){
                (array) in
                DispatchQueue.main.async {
                    if(array.Resultaat == "true"){
                        let defaults = UserDefaults.standard
                        defaults.set(array.Account_Id, forKey: "Account_Id")
                        defaults.set(array.Account_Actief_Kenteken_Id, forKey: "Actief_Kenteken_Id")
                        defaults.set(array.Account_Token, forKey: "Account_Token")
                        defaults.set(array.Bestuurder_Naam, forKey: "Bestuurder_Naam")
                        defaults.set(true, forKey: "isUserLoggedIn")
                        defaults.synchronize()
                        self.verwijsScherm()
                    }else{
                        self.createAlert(title: "Error:", message: "Gebruikersnaam en wachtwoord combinatie niet correct.")
                    }
                }
            }
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
    
    func verwijsScherm(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "ControllerId") as! UITabBarController
        loginViewController.modalPresentationStyle = .overCurrentContext
        loginViewController.modalTransitionStyle = .crossDissolve
        
        self.show(loginViewController, sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
}
