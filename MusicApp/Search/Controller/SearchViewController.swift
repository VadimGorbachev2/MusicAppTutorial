//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 15.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import UIKit


class SearchViewController: UITableViewController {
    
    private let cellId = "cellId"
    let tracks  = [TrackModel(trackName: "Never Gonna Give You Up", artistName: "Rick Astley"), TrackModel(trackName: "Crash", artistName: "Tessa Violet")]
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    // MARK: tableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        return cell
        
    }
}
