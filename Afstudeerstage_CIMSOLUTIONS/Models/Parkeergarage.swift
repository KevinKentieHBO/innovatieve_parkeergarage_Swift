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
    
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
            if let url = URL(string: "\(localhostUrl)/parkeergarages/\(encodedUserId!)/\(encodedToken!)") {
               URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {
                    
                    let d = String(data: data,encoding: .utf8)
                    let decodedData = Data((d?.aesDecrypt()!.utf8)!)

                      do {
                         let res = try JSONDecoder().decode([Parkeergarage].self, from: decodedData)
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


