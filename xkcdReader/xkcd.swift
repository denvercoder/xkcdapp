//
//  xkcd.swift
//  xkcdReader
//
//  Created by Timothy Myers on 8/19/17.
//  Copyright © 2017 Denver Coder. All rights reserved.
//

import Foundation

struct XKCDComic : Decodable {
    let id: String?
    let month: String?
    let num: Int?
    let link: String?
    let year: String?
    let news: String?
    let safe_title: String?
    let transcript: String?
    let alt: String?
    let img: String?
    let title: String?
    let day: String?
    
    init(json: [String: Any]) throws {
        id = json["id"] as? String ?? ""
        month = json["month"] as? String ?? ""
        num = json["num"] as? Int ?? -1
        link = json["link"] as? String ?? ""
        year = json["year"] as? String ?? ""
        news = json["news"] as? String ?? ""
        safe_title = json["safe_title"] as? String ?? ""
        transcript = json["transcript"] as? String ?? ""
        alt = json["alt"] as? String ?? ""
        img = json["img"] as? String ?? ""
        title = json["title"] as? String ?? ""
        day = json["day"] as? String ?? ""
    }
    
    static let baseURL = "http://xkcdapi20170825022619.azurewebsites.net/api/comics"
    
    static func getJSON(completion: @escaping ([XKCDComic]) -> ()) {
        let url = baseURL
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var comicsArray: [XKCDComic] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                        
                        for item in json{
                            try comicsArray.append(XKCDComic.init(json: item))
                        }
                        
                    }
                } catch {
                    print("Problem parsing JSON: \(error)")
                }
                
                completion(comicsArray)
            }
        }
        task.resume()
    }
    
    
    
}
