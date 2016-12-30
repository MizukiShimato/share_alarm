//
//  File.swift
//  movieWatched
//
//  Created by suzukiryota on 2016/11/21.
//  Copyright © 2016年 kiryota. All rights reserved.
//

import Foundation
import Alamofire

import SwiftyJSON
let baseURL = "https://itunes.apple.com/search?"
class ItunesAPI {
    func search(_ term: String, cb: @escaping (_ data: [Track]) -> Void) {
        if let encodedTerm = "https://itunes.apple.com/search?country=jp&term=\(term)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: encodedTerm)
        {
            Alamofire.request(url).responseJSON (completionHandler: { response in
                if let data = response.result.value {
                    let tracks = responseToTracks(JSON(data))
                    cb(tracks)
                }
            })
        }
    }
}

func responseToTracks(_ json: JSON) -> [Track] {
    return json["results"].map { _, json in jsonToTrack(json) }
}

func jsonToTrack(_ json: JSON) -> Track {
    return Track(
        artistName: json["artistName"].stringValue,
        artistViewUrl: json["artistViewUrl"].stringValue,
        artworkUrl: json["artworkUrl60"].stringValue,
        previewUrl: json["previewUrl"].stringValue,
        trackName: json["trackName"].stringValue
    )
}
