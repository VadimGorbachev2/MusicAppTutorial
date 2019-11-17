//
//  NetworkService.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 18.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService {
    
    
    // MARK: loading data from apple search api
    //      чета не робит после переноса логики в этот файл, перестало грузить 
    
    func fetchTracks(searchText: String, complition: @escaping (SearchResponse?) -> Void) {

        let url = "https://itunes.apple.com/search"
        let  paramentrs = ["term":"\(searchText)","limit":"20", "media":"music"]
                    
        Alamofire.request( url, method: .get, parameters: paramentrs, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let error = dataResponse.error {
                print("error recieved requesting data: \(error.localizedDescription)")
                complition(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode( SearchResponse.self, from: data)
                print("objects: ", objects)
                
                
            } catch let jsonError {
                print("failed to decode JSON", jsonError)
                complition(nil)
            }
        }
    }
}
