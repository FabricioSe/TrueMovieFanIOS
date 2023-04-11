//
//  MovieInfoController.swift
//  TrueMovieFanIOS
//
//  Created by admin on 2023-03-31.
//

import UIKit

class MovieInfoViewController : UIViewController {
    
    var selectedMovie : Int = 0
    
    var movieName : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Movie Name"
        lbl.font = .boldSystemFont(ofSize: 40)
        lbl.textColor = .black
        return lbl
    }()
    
    var movieImage : UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(systemName: "film")
        return imv
    }()
    
    var movieSubInformation : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Action · 2020 · 1 hour 36 minutes"
        lbl.font = .systemFont(ofSize: 20)
        lbl.textColor = .black
        return lbl
    }()
    
    var movieOverview : UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 15)
        tv.text = "Avatar (marketed as James Cameron's Avatar) is a 2009 epic science fiction film directed, written, co-produced, and co-edited by James Cameron and starring Sam Worthington, Zoe Saldana, Stephen Lang, Michelle Rodriguez, and Sigourney Weaver. It is the first installment in the Avatar film series. It is set in the mid-22nd century, when humans are colonizing Pandora, a lush habitable moon of a gas giant in the Alpha Centauri star system, in order to mine the valuable mineral unobtanium. The expansion of the mining colony threatens the continued existence of a local tribe of Na'vi, a humanoid species indigenous to Pandora. The title of the film refers to a genetically engineered Na'vi body operated from the brain of a remotely located human that is used to interact with the natives of Pandora."
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .black
        return tv
    }()
    
    
    
    
    
    //Video https://www.youtube.com/watch?v=(key)
    
    //var videoplayer : CachedPlayerView
    
    override func viewDidLoad(){
        super.viewDidLoad()

        print(selectedMovie)
        
        self.view.addSubview(movieName)
        self.view.addSubview(movieImage)
        self.view.addSubview(movieSubInformation)
        self.view.addSubview(movieOverview)
        
        self.view.backgroundColor = .white
        applyConstraints()
    }
    
    func applyConstraints(){
        movieName.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieSubInformation.translatesAutoresizingMaskIntoConstraints = false
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            movieName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15 ),
            movieName.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            movieName.heightAnchor.constraint(equalToConstant: 50),
            movieName.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            movieImage.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 10),
            movieImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            
            movieSubInformation.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 5),
            movieSubInformation.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            movieSubInformation.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            movieSubInformation.heightAnchor.constraint(equalToConstant: 30),
            
            movieOverview.topAnchor.constraint(equalTo: movieSubInformation.bottomAnchor, constant: 5),
            movieOverview.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            movieOverview.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            movieOverview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        
        
    }
    
    
    
}
