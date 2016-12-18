//
//  Track.swift
//  movieWatched
//
//  Created by suzukiryota on 2016/11/21.
//  Copyright © 2016年 kiryota. All rights reserved.
//

import Foundation

class Track {
    let artistName: String
    let artistViewUrl: String
    let artworkUrl: String
    let previewUrl: String
    let trackName: String
    init(
        artistName: String,
        artistViewUrl: String,
        artworkUrl: String,
        previewUrl: String,
        trackName: String
        ) {
        self.artistName = artistName
        self.artistViewUrl = artistViewUrl
        self.artworkUrl = artworkUrl
        self.previewUrl = previewUrl
        self.trackName = trackName
    }
}
