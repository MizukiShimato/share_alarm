//
//  TrackList.swift
//  movieWatched
//
//  Created by suzukiryota on 2016/11/22.
//  Copyright © 2016年 kiryota. All rights reserved.
//

import Foundation
import UIKit

protocol TrackListDelegate: TrackListCellDelegate {
    func cellHandler(_ track: Track) -> Void
}

class TrackList: UITableView {
    var trackListDelegate: TrackListDelegate?
    
    var currentTrack: Track?
    var tracks: [Track] = []
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        let cell = UINib(nibName: "TrackListCell", bundle: nil)
        self.register(cell, forCellReuseIdentifier: "TrackListCell")
        self.delegate = self
        self.dataSource = self
    }
}


extension TrackList: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let track = tracks[indexPath.row]
        let cell = self.dequeueReusableCell(withIdentifier: "TrackListCell") as! TrackListCell
        
        cell.setTrack(track)
        if let currentTrack = currentTrack {
            cell.statePlay(currentTrack.previewUrl == track.previewUrl)
        }
        cell.delegate = self.trackListDelegate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = self.trackListDelegate {
            delegate.cellHandler(tracks[indexPath.row])
        }
    }
    
}
