//
//  Abonnement.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 06/04/2021.
//

import Foundation

//Structuur van een abonnement aanduiden
struct Abonnement : Decodable{
    let abonnement_Id: Int
    let abonnement_Tarief: Float
    let abonnement_Type: String
    let abonnement_Beschrijving: String
}

//Structuur van een abonnement aanduiden
struct AbonnementGebruiker : Decodable{
    let abonnement_Id: Int
    let abonnement_Tarief: Float
    let abonnement_Type: String
    let abonnement_Beschrijving: String
    let abonnement_Begindatum :String
    let abonnement_Einddatum : String
    let abonnement_Status : String
    let parkeergarage_Naam: String
}

//geef alle abonnementen van een parkeergarage terug met een Rest Api
func getAbonnementParkeergarage(parkeergarageId : Int, _ completion: @escaping ([Abonnement]) -> ()) {
    
    let encodedParkeergarageId = String(parkeergarageId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let restURL = "\(herokuUrl)/abonnement/\(encodedParkeergarageId!)/\(encodedUserId!)/\(encodedToken!)"
    print(restURL)
    
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

            do {
               let res = try JSONDecoder().decode([Abonnement].self, from: decodedData)
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

//geef alle abonnementen van een auto terug met een Rest Api
func getAbonnementAutoId(_ completion: @escaping ([AbonnementGebruiker]) -> ()) {
    
    let autoId : Int = UserDefaults.standard.integer(forKey: "Actief_Kenteken_Id")
    
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedAutoId = String(autoId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let restURL = "\(herokuUrl)/abonnement/get/\(encodedAutoId!)/\(encodedUserId!)/\(encodedToken!)"
    print(restURL)
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

            do {
               let res = try JSONDecoder().decode([AbonnementGebruiker].self, from: decodedData)
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
