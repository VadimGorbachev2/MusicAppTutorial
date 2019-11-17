//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 15.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import UIKit
import Alamofire

//struct Track {
//    var trackName: String
//    var artistName: String
//}

class SearchViewController: UITableViewController {
    
    private let cellId = "cellId"
    private var timer: Timer?
    var networkService = NetworkService()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: loading data solution
    var tracks  =  [Track]()

    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupSearchBar()
    }
    
    // MARK: tableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = #imageLiteral(resourceName: "Image")
        return cell
    }
    // MARK: SearchController customization
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
}


// MARK: Search bar extension with reloading data from apple search api
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     //   print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.fetchTracks(searchText: searchText) { [weak self] (searchResults) in
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
         
    }
}
