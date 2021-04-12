//
//  Account.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 10/04/2021.
//

import Foundation

struct Account : Decodable{
    let Resultaat : String
    let Account_Id : Int
    let Account_Token : String
    let Account_Actief_Kenteken_Id : Int
    let Bestuurder_Naam : String
}

struct UserData : Decodable{
    let Account_Email : String
    let Account_Saldo : Double
    let Bestuurder_Geboortedatum : String
}

func checkLogin(gebruikersnaam : String, wachtwoord : String, _ completion: @escaping (Account) -> ()) {
    
    let encodedWachtwoord = wachtwoord.aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedGebruikersnaam = gebruikersnaam.aesEncrypt()?.stringByAddingPercentEncodingToData()
    print(encodedWachtwoord)
    print(encodedGebruikersnaam)
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    if let url = URL(string:"\(herokuUrl)/account/\(encodedGebruikersnaam!)/\(encodedWachtwoord!)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

              do {
                 let res = try JSONDecoder().decode(Account.self, from: decodedData)
                print(res)
                completion(res)
                return
              } catch let error {
                 print(error)
              }
          }
       }.resume()
    }
}

func getUserData(_ completion: @escaping (UserData) -> ()) {
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    if let url = URL(string:"\(herokuUrl)/userdata/\(encodedUserId!)/\(encodedToken!)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

              do {
                 let res = try JSONDecoder().decode(UserData.self, from: decodedData)
                print(res)
                completion(res)
                return
              } catch let error {
                 print(error)
              }
          }
       }.resume()
    }
}
