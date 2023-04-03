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
        let payload : [String:String] = [:]
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: "GET", payload: payload, successHandler: successHandler, failHandler: failHandler)
    }
    
    //https://api.themoviedb.org/3/movie/upcoming?api_key=091170c8beb6b16a8d303013a81b85a1&language=en-US&page=1&region=ca
}

// Codable: transform bytes into a string or an object
struct tmdbAPIMovies: Codable {

    var poster_path : String
    var title : String
    var id : Int
    
    static func decode( json : [String:Any]) -> tmdbAPIMovies? {
        let decoder = JSONDecoder()
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(tmdbAPIMovies.self, from: data)
            return object
        } catch {
        }
        return nil
    }
}
