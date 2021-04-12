//
//  Betaaltarief.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 24/03/2021.
//

import Foundation

//Object Betaaltarief
struct Betaaltarief : Decodable {
    let id: Int
    let type: String
    let waarde: Double
}


//haal alle betaaltarieven op met een REST Api
func getTestAllTarieven(_ completion: @escaping ([Betaaltarief]) -> ()) {
    
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
            if let url = URL(string: "\(herokuUrl)/betaaltarief/\(encodedUserId!)/\(encodedToken!)") {
               URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {
                    
                    let d = String(data: data,encoding: .utf8)
                    let decodedData = Data((d?.aesDecrypt()!.utf8)!)
                    
                    
                      do {
                        let res = try JSONDecoder().decode([Betaaltarief].self, from: decodedData)
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

