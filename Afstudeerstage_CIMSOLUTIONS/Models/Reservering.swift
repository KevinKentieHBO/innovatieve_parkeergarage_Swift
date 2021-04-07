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
    
    let restURL = "\(localhostUrl)/reservering/"+res.reservering_Datum+"/"+res.reservering_Begintijd+"/"+res.reservering_Eindtijd+"/"+String(res.reservering_Auto_Id)+"/"+String(res.reservering_Parkeergarage_Id)
    print(restURL)
    
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
    
    let restURL = "\(localhostUrl)/reservering/verwijder/\(res.reservering_Id)"
    print(restURL)
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {

            do {
               let res = try JSONDecoder().decode(Response.self, from: data)
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
    
    let restURL = "\(localhostUrl)/reservering/update/\(res.reservering_Datum)/\(res.reservering_Begintijd)/\(res.reservering_Eindtijd)/\(res.reservering_Id)/\(res.reservering_parkeergarage_Id)"
    print(restURL)
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {

            do {
               let res = try JSONDecoder().decode(Response.self, from: data)
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
    
    let autoId = 1
    if let url = URL(string: "\(localhostUrl)/reserveringen/"+String(autoId)) {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {

              do {
                 let res = try JSONDecoder().decode([InfoReservering].self, from: data)
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
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let autoId = 1
    if let url = URL(string:"\(localhostUrl)/reservering/get/\(datum)/\(begintijd)/\(eindtijd)/\(autoId)/\(parkeergarageid)") {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {

              do {
                 let res = try JSONDecoder().decode(InfoReservering.self, from: data)
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
