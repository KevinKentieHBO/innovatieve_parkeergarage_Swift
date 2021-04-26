//
//  Auto.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 15/04/2021.
//

import Foundation

struct Auto : Decodable {
    let Auto_Id : Int
    let Auto_Kenteken: String
}

struct Resultaat : Decodable {
    let resultaat : String
}

//geef alle Autos van een gebruiker terug met een Rest Api
func getAutos(_ completion: @escaping ([Auto]) -> ()) {
    
    let autoId : Int = UserDefaults.standard.integer(forKey: "Actief_Kenteken_Id")
    
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let restURL = "\(localhostUrl)/allauto/get/\(encodedUserId!)/\(encodedToken!)"
    print(restURL)
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

            do {
               let res = try JSONDecoder().decode([Auto].self, from: decodedData)
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

//Aanmaken van een Auto
func toevoegenAuto(kenteken : String, _ completion: @escaping (Resultaat) -> ()) {
    
    
    let encodedKenteken = String(kenteken).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"

    if let url = URL(string:"\(localhostUrl)/addauto/\(encodedKenteken!)/\(encodedUserId!)/\(encodedToken!)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

              do {
                 let res = try JSONDecoder().decode(Resultaat.self, from: decodedData)
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

//verwijderen van een Auto
func verwijderAuto(autoid : Int, _ completion: @escaping (Resultaat) -> ()) {
    
    
    let encodedAutoId = String(autoid).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"

    if let url = URL(string:"\(localhostUrl)/deleteauto/\(encodedAutoId!)/\(encodedUserId!)/\(encodedToken!)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

              do {
                 let res = try JSONDecoder().decode(Resultaat.self, from: decodedData)
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

