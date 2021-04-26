//
//  Reservering.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 26/03/2021.
//

import Foundation

//Object voor response
struct Response : Decodable{
    let resultaat : String
}

//Object reservering
struct Reservering : Decodable{
    let reservering_Id: Int
    let reservering_Parkeerplaats_Id: Int
    let reservering_Begintijd: String
    let reservering_Eindtijd: String
    let reservering_Datum: String
    let reservering_Auto_Id: Int
}

//Object reservering voor de info pagina
struct InfoReservering : Decodable{
    let reservering_Id: Int
    let reservering_Parkeerplaats_Id: Int
    var reservering_Begintijd: String
    var reservering_Eindtijd: String
    var reservering_Datum: String
    let reservering_Parkeerplaats_laag: Int
    let reservering_Parkeerplaats_plek: Int
    let reservering_Parkeergarage: String
    let reservering_ParkeergarageLocatie: String
    let reservering_Parkeergarage_Opening: String
    let reservering_Parkeergarage_Sluiting: String
    let reservering_parkeergarage_Id : Int
}

//Object reservering voor het wegschrijven
struct makeReservering : Decodable{
    let reservering_Begintijd: String
    let reservering_Eindtijd: String
    let reservering_Datum: String
    let reservering_Auto_Id: Int
    let reservering_Parkeergarage_Id: Int
}

//Aanmaken van een Reservering met een Rest Api
func createReservering(res : makeReservering) {
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let encodedResDat = String(res.reservering_Datum).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedResBtijd = String(res.reservering_Begintijd).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedResEtijd = String(res.reservering_Eindtijd).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedResAutoId = String(res.reservering_Auto_Id).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedResParId = String(res.reservering_Parkeergarage_Id).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
  
    let restURL = "\(localhostUrl)/reservering/\(encodedResDat!)/\(encodedResBtijd!)/\(encodedResEtijd!)/\(encodedResAutoId!)/\(encodedResParId!)/\(encodedUserId!)/\(encodedToken!)"
    
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let response = response {
            print(response)
        }
       }.resume()
    }
}

//Verwijderen van een reservering
func verwijderReserveringRest(res : InfoReservering, _ completion: @escaping (Response) -> ()) {
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let encodedResId = String(res.reservering_Id).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let restURL = "\(localhostUrl)/reservering/verwijder/\(encodedResId!)/\(encodedUserId!)/\(encodedToken!)"
    print(restURL)
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

            do {
               let res = try JSONDecoder().decode(Response.self, from: decodedData)
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

//update van een reservering
func updateReserveringRest(res : InfoReservering, _ completion: @escaping (Response) -> ()) {
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let encodedResDat = String(res.reservering_Datum).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedResBtijd = String(res.reservering_Begintijd).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedResEtijd = String(res.reservering_Eindtijd).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedResId = String(res.reservering_Id).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedResParId = String(res.reservering_parkeergarage_Id).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let restURL = "\(localhostUrl)/reservering/update/\(encodedResDat!)/\(encodedResBtijd!)/\(encodedResEtijd!)/\(encodedResId!)/\(encodedResParId!)/\(encodedUserId!)/\(encodedToken!)"
    print(restURL)
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

            do {
               let res = try JSONDecoder().decode(Response.self, from: decodedData)
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


//Ophalen van alle reserveringen van een gebruiker met het kenteken
func getReserveringenVanGebruiker(_ completion: @escaping ([InfoReservering]) -> ()) {
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let encodedAutoId = String(UserDefaults.standard.integer(forKey: "Actief_Kenteken_Id")).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    print("\(localhostUrl)/reserveringen/\(encodedAutoId!)/\(encodedUserId!)/\(encodedToken!)")
    
    if let url = URL(string: "\(localhostUrl)/reserveringen/\(encodedAutoId!)/\(encodedUserId!)/\(encodedToken!)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

              do {
                 let res = try JSONDecoder().decode([InfoReservering].self, from: decodedData)
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
    
//Ophalen van een reservering die zojuist gemaakt is
func getZojuistGemaakteReservering(datum : String, begintijd : String, eindtijd : String, parkeergarageid : Int, _ completion: @escaping (InfoReservering) -> ()) {
    
    let encodedDatum = String(datum).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedBegintijd = String(begintijd).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedEindtijd = String(eindtijd).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedParkeergarageId = String(parkeergarageid).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedAutoId = String(UserDefaults.standard.integer(forKey: "Actief_Kenteken_Id")).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"

    if let url = URL(string:"\(localhostUrl)/reservering/get/\(encodedDatum!)/\(encodedBegintijd!)/\(encodedEindtijd!)/\(encodedAutoId!)/\(encodedParkeergarageId!)/\(encodedUserId!)/\(encodedToken!)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
            
            let d = String(data: data,encoding: .utf8)
            let decodedData = Data((d?.aesDecrypt()!.utf8)!)

              do {
                 let res = try JSONDecoder().decode(InfoReservering.self, from: decodedData)
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
