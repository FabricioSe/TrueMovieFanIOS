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
    static let api_key = "7af60d16a4a4e9c424a7bcafba970288"
    static var page = 1
    static var movieID = Int()
    
    static func discoverMovies( successHandler: @escaping (_ httpStatusCode : Int, _ response :
                                                            [String: Any]) -> Void,
                                failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage:
                                                            String) -> Void) {
        let endPoint = "/discover/movie?api_key=\(api_key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_watch_monetization_types=flatrate"
        let payload : [String:String] = [:]
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: "GET", payload: payload, successHandler: successHandler, failHandler: failHandler)
    }
    
    static func upcomingMovies( successHandler: @escaping (_ httpStatusCode : Int, _ response :
                                                            [String: Any]) -> Void,
                                failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage:
                                                            String) -> Void) {
        let endPoint = "/movie/upcoming?api_key=\(api_key)&language=en-US&page=\(page)&region=ca"
        let payload : [String:String] = [:]
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: "GET", payload: payload, successHandler: successHandler, failHandler: failHandler)
    }
    
    static func movieDetails( successHandler: @escaping (_ httpStatusCode : Int, _ response : [String : Any]) -> Void,
                              failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage: String) -> Void) {
        let endPoint = "/movie/\(movieID)?api_key=\(api_key)&language=en-US"
        let payload : [String:String] = [:]
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: "GET", payload: payload, successHandler: successHandler, failHandler: failHandler)
    }
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

struct tmdbAPIMovieDetail: Codable {
    
    var title : String
    var poster_path : String
    var overview : String
    var release_date : String
    var runtime : Int
    
    static func decode( json : [String : Any]) -> tmdbAPIMovieDetail? {
        let decoder = JSONDecoder()
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(tmdbAPIMovieDetail.self, from: data)
            return object
        } catch {
        }
        return nil
    }
}
