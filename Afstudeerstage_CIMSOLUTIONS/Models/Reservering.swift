//
//  Reservering.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 26/03/2021.
//

import Foundation

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
    let reservering_Begintijd: String
    let reservering_Eindtijd: String
    let reservering_Datum: String
    let reservering_Parkeerplaats_laag: Int
    let reservering_Parkeerplaats_plek: Int
    let reservering_Parkeergarage: String
    let reservering_ParkeergarageLocatie: String
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
    let restURL = "http://localhost:8080/reservering/"+res.reservering_Datum+"/"+res.reservering_Begintijd+"/"+res.reservering_Eindtijd+"/"+String(res.reservering_Auto_Id)+"/"+String(res.reservering_Parkeergarage_Id)
    print(restURL)
    
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let respone = response {
            print(response)
        }
       }.resume()
    }
}

//Ophalen van alle reserveringen van een gebruiker met het kenteken
func getReserveringenVanGebruiker(_ completion: @escaping ([InfoReservering]) -> ()) {
    let autoId = 1
    if let url = URL(string: "http://localhost:8080/reserveringen/"+String(autoId)) {
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
