//
//  GetAllComics.swift
//  xkcdReader
//
//  Created by Timothy Myers on 8/27/17.
//  Copyright © 2017 Denver Coder. All rights reserved.
//

import Foundation

class GetAllComics {
    
    static func GetEmAll(completionHandler: @escaping (_ latestComicNumber: [XKCDComic]) -> ()) {
        
        let currentXKCDComicURL = "http://xkcdapi20170825022619.azurewebsites.net/api/comics"
        
        let url = URL(string: currentXKCDComicURL)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, err) in
            var comic: [XKCDComic] = []
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        try comic.append(XKCDComic.init(json: json))
                    }
                } catch {
                    print("Error")
                }
                completionHandler(comic)
            }
        }
        task.resume()
    }
}
