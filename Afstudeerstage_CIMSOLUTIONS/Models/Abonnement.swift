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

//geef alle abonnementen van een parkeergarage terug met een Rest Api
func getAbonnementParkeergarage(parkeergarageId : Int, _ completion: @escaping ([Abonnement]) -> ()) {
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let restURL = "\(localhostUrl)/abonnement/\(parkeergarageId)"
    print(restURL)
    if let url = URL(string: restURL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {

            do {
               let res = try JSONDecoder().decode([Abonnement].self, from: data)
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
