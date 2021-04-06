//
//  Parkeergarage.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 25/03/2021.
//

import Foundation

//Object parkeergarage
struct Parkeergarage : Decodable {
        let parkeergarage_Id: Int
        let parkeergarage_Naam: String
        let parkeergarage_Locatie: String
        let parkeergarage_Parkeerlagen: Int
        let parkeergarage_Aantal_Plaatsen: Int
        let parkeergarage_Opening: String
        let parkeergarage_Sluiting: String
}

//geef alle parkeergarages terug met een Rest Api
func getAllParkeergarages(_ completion: @escaping ([Parkeergarage]) -> ()) {
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
            if let url = URL(string: "\(herokuUrl)/parkeergarages") {
               URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {

                      do {
                         let res = try JSONDecoder().decode([Parkeergarage].self, from: data)
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


