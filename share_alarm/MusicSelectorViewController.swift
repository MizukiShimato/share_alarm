//
//  ItunesViewController.swift
//  movieWatched
//
//  Created by suzukiryota on 2016/11/22.
//  Copyright © 2016年 kiryota. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class MusicSelectorViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var avContainer: UIView!
    var currentTrack: Track?
    var currentButton: UIButton?
    
    var avPlayer: AVPlayer!
    var avLayer: AVPlayerLayer!
    
    
    
    var trackList: TrackList!
    override func viewDidLoad() {
        trackList = UINib(nibName: "TrackList", bundle: nil).instantiate(withOwner: self, options: nil).first as? TrackList
        searchBar.delegate = self
        trackList.trackListDelegate = self
        addSubvieWithAutoLayout(trackList, parentView: parentView)
        
    }
    
    func searchTracks(_ text: String) {
        ItunesAPI().search(text) { data in
            self.trackList.tracks = data
            self.trackList.reloadData()
        }
        
    }
}

extension MusicSelectorViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchTracks(text)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchTracks(text)
        }
    }
    
}

extension MusicSelectorViewController: TrackListDelegate {
    func cellHandler(_ track: Track) {
    }
    
    func leftButtonHandler(_ sender: UIButton, _ track: Track) {
        sender.setTitle("再生中", for: UIControlState.normal)
        if let oldPlayer = self.avPlayer, let button = currentButton, let oldTrack = self.currentTrack {
            if track.previewUrl == oldTrack.previewUrl {
                return
            } else {
                button.setTitle("再生", for: UIControlState.normal)
                oldPlayer.pause()
            }
        }
        self.currentTrack = track
        self.currentButton = sender
        
        if let url = URL(string: track.previewUrl) {
            self.avPlayer = AVPlayer(url: url)
            self.avLayer = AVPlayerLayer(player: self.avPlayer!)
            self.avContainer.layer.addSublayer(self.avLayer!)
            self.avPlayer.play()
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(MusicSelectorViewController.musicFin(_:)),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: avPlayer?.currentItem)
        }
    }
    
    func musicFin(_ notification: NSNotification) {
        if let button = currentButton {
            button.setTitle("再生", for: UIControlState.normal)
        }
    }
    
    func rightButtonHandler(_ sender: UIButton, _ track: Track) {
    }
}
