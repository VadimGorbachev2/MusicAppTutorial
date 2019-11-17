//
//  TrackModel.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 15.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import Foundation

struct TrackModel {
    var trackName: String
    var collectionName: String
    var artistName: String
    var artworkUrl100: String
    
}


struct SearchResponse {
    var reusltCount: Int
    var results: [TrackModel]
}
