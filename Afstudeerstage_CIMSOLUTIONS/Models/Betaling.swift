//
//  Betaling.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 26/04/2021.
//

import Foundation

struct Betaling : Decodable{
    let Betaling_id : Int
    let Betaling_Bedrag : Double
    let Betaling_Datum : String
    let Betaling_Tijd : String
}

func createBetaling(kosten : String, _ completion: @escaping ([Abonnement]) -> ()) {
    
    let encodedKosten = String(kosten).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let herokuUrl : String = "https://javainnovatieveparkeergarage.herokuapp.com"
    let localhostUrl : String = "http://localhost:8080"
    
    let userId = UserDefaults.standard.integer(forKey: "Account_Id")
    let token = UserDefaults.standard.string(forKey: "Account_Token")
    let encodedUserId = String(userId).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedToken = String(token!).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedDatum = String(Date().string(format: "yyyy-MM-dd")).aesEncrypt()?.stringByAddingPercentEncodingToData()
    let encodedTijd = String(Date().string(format: "HH:mm")).aesEncrypt()?.stringByAddingPercentEncodingToData()
    
    let restURL = "\(localhostUrl)/betaling/create/\(encodedKosten!)/\(encodedDatum!)/\(encodedTijd!)/\(encodedUserId!)/\(encodedUserId!)/\(encodedToken!)"
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

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
