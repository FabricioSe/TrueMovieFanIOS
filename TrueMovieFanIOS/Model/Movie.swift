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
    var release_date : String = ""
    
    init(title: String, posterURL: String, id: Int) {
        self.title = title
        self.posterURL = posterURL
        self.id = id
    }
    
    init(title: String, id: Int, release_date: String){
        self.title = title
        self.id = id
        self.release_date = release_date
    }
    
    func toString() -> String {
        return "Title: \(title), ID: \(id), Year: \(release_date)"
    }
}
