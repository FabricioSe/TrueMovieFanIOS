//
//  Movie.swift
//  TrueMovieFanIOS
//
//  Created by Fabricio Segovia on 2023-04-11.
//

import Foundation

class Movie {
    var title : String = ""
    var posterURL : String = ""
    var id : Int = 0
    
    init(title: String, posterURL: String, id: Int) {
        self.title = title
        self.posterURL = posterURL
        self.id = id
    }
    
    func toString() -> String {
        return "Title: \(title), ID: \(id)"
    }
}
