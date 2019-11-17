//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 15.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import UIKit
import Alamofire


class SearchViewController: UITableViewController {
    
    private let cellId = "cellId"
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: data temporary solution
    let tracks  = [TrackModel(trackName: "Never Gonna Give You Up", artistName: "Rick Astley"), TrackModel(trackName: "Crash", artistName: "Tessa Violet")]
    
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     //   print(searchText)
        
        let url = "https://itunes.apple.com/search?term=\(searchText)"
        Alamofire.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("error recieved requesting data: \(error.localizedDescription)")
                return
            }
            
            guard let data = dataResponse.data else { return }
            let someString = String(data: data, encoding: .utf8)
            print(someString ?? "")
        }
    }
}
