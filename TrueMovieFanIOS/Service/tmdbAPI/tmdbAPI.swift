//
//  tmdbAPI.swift
//  TrueMovieFanIOS
//
//  Created by Fabricio Segovia on 2023-03-31.
//

import Foundation
import UIKit

class tmdbAPI {
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static func discoverMovies( successHandler: @escaping (_ httpStatusCode : Int, _ response :
                                                            [String: Any]) -> Void,
                                failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage:
                                                            String) -> Void) {
        let api_key = "7af60d16a4a4e9c424a7bcafba970288"
        let endPoint = "/discover/movie?api_key=\(api_key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: "GET", successHandler: successHandler, failHandler: failHandler)
    }
}

// Codable: transform bytes into a string or an object
struct tmdbAPICurrent: Codable {
    var results : [Movie]
    
    struct Movie : Codable {
        var title : String
        var poster_path : String
    }
    
    static func decode( json : [String:Any]) -> tmdbAPICurrent? {
        let decoder = JSONDecoder()
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(tmdbAPICurrent.self, from: data)
            return object
        } catch {
        }
        return nil
    }
}
