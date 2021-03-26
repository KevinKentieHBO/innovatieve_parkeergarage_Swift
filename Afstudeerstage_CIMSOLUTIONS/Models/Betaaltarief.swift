//
//  Betaaltarief.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 24/03/2021.
//

import Foundation

struct Betaaltarief : Decodable {
    let id: Int
    let type: String
    let waarde: Double
}

//haal alle betaaltarieven op
func getTestAllTarieven(_ completion: @escaping ([Betaaltarief]) -> ()) {
            if let url = URL(string: "http://localhost:8080/betaaltarief") {
               URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {

                      do {
                         let res = try JSONDecoder().decode([Betaaltarief].self, from: data)
                        print(res.self)
                        completion(res)
                        return
                      } catch let error {
                         print(error)
                      }
                  }
               }.resume()
        }
}
