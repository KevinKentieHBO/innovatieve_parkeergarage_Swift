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

struct ResultaatSaldo : Decodable {
    let resultaat : String
    let dagtarief : Double
}

struct Res : Decodable {
    let resultaat : String
}

func checkLogin(gebruikersnaam : String, wachtwoord : String, _ completion: @escaping (Account) -> ()) {
    
    let encodedWachtwoord = wachtwoord.aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedGebruikersnaam = gebruikersnaam.aesEncrypt()?.stringByAddingPercentEncodingToData()
    print(encodedWachtwoord)
    print(encodedGebruikersnaam)
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    
    if let url = URL(string:"\(localhostUrl)/account/\(encodedGebruikersnaam!)/\(encodedWachtwoord!)") {
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

func checkSaldo(parkeergarageid : Int, _ completion: @escaping (ResultaatSaldo) -> ()){
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedParkeergarageId = String(parkeergarageid).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    
    if let url = URL(string:"\(localhostUrl)/saldocheck/\(encodedParkeergarageId!)/\(encodedUserId!)/\(encodedUserId!)/\(encodedToken!)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

              do {
                 let res = try JSONDecoder().decode(ResultaatSaldo.self, from: decodedData)
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
    
    
    if let url = URL(string:"\(localhostUrl)/userdata/\(encodedUserId!)/\(encodedToken!)") {
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

func updateSaldo(saldo : String,_ completion: @escaping (Res) -> ()) {
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedSaldo = String(saldo).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    
    if let url = URL(string:"\(localhostUrl)/account/updateplus/\(encodedUserId!)/\(encodedSaldo!)/\(encodedUserId!)/\(encodedToken!)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

              do {
                 let res = try JSONDecoder().decode(Res.self, from: decodedData)
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
