//
//  Reservering.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 26/03/2021.
//

import Foundation

struct Reservering : Decodable{
    let reservering_Id: Int
    let reservering_Parkeerplaats_Id: Int
    let reservering_Begintijd: String
    let reservering_Eindtijd: String
    let reservering_Datum: String
    let reservering_Auto_Id: Int
}

struct makeReservering : Decodable{
    let reservering_Begintijd: String
    let reservering_Eindtijd: String
    let reservering_Datum: String
    let reservering_Auto_Id: Int
}

func createReservering(res : makeReservering) {
    let restURL = "http://localhost:8080/reservering/"+res.reservering_Datum+"/"+res.reservering_Begintijd+"/"+res.reservering_Eindtijd+"/"+String(res.reservering_Auto_Id)
    print(restURL)
    
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let respone = response {
            print(response)
        }
       }.resume()
    }
}
