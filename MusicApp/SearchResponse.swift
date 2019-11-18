//
//  TrackModel.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 15.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import Foundation

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?   //  album's icon
    
}

// Decodable for work with apple search api json

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}
