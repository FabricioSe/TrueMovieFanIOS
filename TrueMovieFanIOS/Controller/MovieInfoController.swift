//
//  MovieInfoController.swift
//  TrueMovieFanIOS
//
//  Created by admin on 2023-03-31.
//

import UIKit

class MovieInfoViewController : UIViewController {
    
    var selectedMovie : Int = 0
    
    //Video https://www.youtube.com/watch?v=(key)
    
    //var videoplayer : CachedPlayerView
    
    override func viewDidLoad(){
        super.viewDidLoad()

        print(selectedMovie)
        
        self.view.backgroundColor = .red
    }
}
