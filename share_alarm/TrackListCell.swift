//
//  TrackListCell.swift
//  movieWatched
//
//  Created by suzukiryota on 2016/11/22.
//  Copyright © 2016年 kiryota. All rights reserved.
//

import Foundation
import UIKit

protocol TrackListCellDelegate {
    func leftButtonHandler (_ sender: UIButton, _ track: Track) -> Void
    func rightButtonHandler (_ sender: UIButton, _ track: Track) -> Void
}

class TrackListCell: UITableViewCell, ImageFetchManager {
    @IBOutlet weak var preview: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    var track: Track?
    var delegate: TrackListCellDelegate?
    
    @IBAction func rightButton(_ sender: UIButton) {
        if let delegate = delegate, let track = track {
            delegate.rightButtonHandler(sender, track)
        }
    }
    
    @IBAction func leftButton(_ sender: UIButton) {
        if let delegate = delegate, let track = track {
            delegate.leftButtonHandler(sender, track)
        }
    }
    
    func setTrack(_ track: Track) {
        self.track = track
        trackName.text = track.trackName
        fetchImg(track.artworkUrl, cb: { data in
            if let data = data {
                self.preview.image = UIImage(data: data)
            }
        })
    }
}
