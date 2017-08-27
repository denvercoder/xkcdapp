//
//  GetCurrentComic.swift
//  xkcdReader
//
//  Created by Timothy Myers on 8/19/17.
//  Copyright © 2017 Denver Coder. All rights reserved.
//

import Foundation

class MostRecent {
    
    static func comicNumber(completionHandler: @escaping (_ latestComicNumber: [XKCDComic]) -> ()) {
        
        let currentXKCDComicURL = "https://xkcd.com/info.0.json"
        
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
