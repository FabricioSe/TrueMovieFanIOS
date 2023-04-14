//
//  MovieInfoController.swift
//  TrueMovieFanIOS
//
//  Created by admin on 2023-03-31.
//

import UIKit
import AVFoundation
import AVKit
import YouTubePlayerKit

class MovieInfoViewController : UIViewController {
    
    var selectedMovie : Int = 0
    
    var movieGenre : String?
    var movieReleaseYear : String?
    var movieDuration : String?
    
    var movieName : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Title not available"
        lbl.font = .boldSystemFont(ofSize: 30)
        lbl.numberOfLines = 2
        lbl.textColor = .black
        return lbl
    }()
    
    var movieImage : UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(systemName: "film")
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    var movieSubInformation : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Action · yyyy · n hour nn minutes"
        lbl.font = .systemFont(ofSize: 18)
        lbl.textColor = .black
        return lbl
    }()
    
    var movieOverview : UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 15)
        tv.text = "The description for this film is not available."
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .black
        return tv
    }()
    
//    var trailerKey = "cE0wfjsybIQ"
    var trailerKey : String = "dQw4w9WgXcQ"
    
    override func viewDidLoad(){
        super.viewDidLoad()

        print(selectedMovie)
        movieDetails()
        getTrailerKey()
        
        self.view.addSubview(movieName)
        self.view.addSubview(movieImage)
        self.view.addSubview(movieSubInformation)
        self.view.addSubview(movieOverview)
        
        self.view.backgroundColor = .white
        applyConstraints()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        movieImage.isUserInteractionEnabled = true
        movieImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        /*
        let videoURLString = "https://www.youtube.com/watch?v=ZQhMW50wmwg"
        if let videoURL = URL(string: videoURLString){
            playVideo(url: videoURL)
            print(videoURLString)
        }
         */
        
        
        let youTubePlayerViewController = YouTubePlayerViewController(
            player: "https://www.youtube.com/watch?v="
        )

        //Auto Play the video
        youTubePlayerViewController.player.configuration = .init(
            autoPlay: true
        )
        
        //Modify the Video Link
        youTubePlayerViewController.player.source = .video(id: trailerKey)
        
        //Pop up the video player
        self.present(youTubePlayerViewController, animated: true)
        
    }
    
    /*
    func playVideo(url: URL){
        let player = AVPlayer(url: url)
        
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true){
            playerViewController.player!.play()
        }
    }
     */
    
    
    
    func applyConstraints(){
        movieName.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieSubInformation.translatesAutoresizingMaskIntoConstraints = false
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            movieName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15 ),
            movieName.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            movieName.heightAnchor.constraint(equalToConstant: 80),
            movieName.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            movieImage.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 10),
            movieImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 400),
            
            movieSubInformation.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10),
            movieSubInformation.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            movieSubInformation.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            movieSubInformation.heightAnchor.constraint(equalToConstant: 30),
            
            movieOverview.topAnchor.constraint(equalTo: movieSubInformation.bottomAnchor, constant: 10),
            movieOverview.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            movieOverview.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            movieOverview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
    
    // Function coming from the API to fetch movie Details
    func movieDetails() {
        tmdbAPI.movieID = self.selectedMovie
        tmdbAPI.movieDetails { httpStatusCode, response in
            let currentMovie = response as [String : Any]
            let genre = currentMovie["genres"] as? [[String : Any]]
            
            let movieDetail = tmdbAPIMovieDetail.decode(json: currentMovie)
            DispatchQueue.main.async {
                if (movieDetail != nil) {
                    
                    self.movieName.text = movieDetail!.title
                    self.movieGenre = genre?.first?["name"] as? String
                    self.movieReleaseYear = String(movieDetail!.release_date.prefix(4))
                    self.movieDuration = String(format: "%d hour %02d min", movieDetail!.runtime / 60, movieDetail!.runtime % 60)

                    if (self.movieGenre != nil){
                        self.movieSubInformation.text = "\(self.movieGenre!) · \(self.movieReleaseYear!) · \(self.movieDuration!)"
                    }
                    else{
                        self.movieSubInformation.text = "General · \(self.movieReleaseYear!) · \(self.movieDuration!)"
                    }
                   // self.movieSubInformation.text = "\(self.movieGenre!) · \(self.movieReleaseYear!) · \(self.movieDuration!)"
                    
                    self.movieOverview.text = movieDetail!.overview
                    self.movieImage.fetchUImageFromURL(url: URL(string: "https://image.tmdb.org/t/p/w500\(movieDetail!.poster_path)")!)
                    
                } else {
                }
            }
        } failHandler: { httpStatusCode, errorMessage in
            print(errorMessage)
        }        
    }
    
    // Function coming from the API to get the trailerKey
    func getTrailerKey() {
        tmdbAPI.getTrailerForMovie { httpStatusCode, response in
            let current = response as [String:Any]
            let results = current["results"] as? [[String:Any]]
            
            for index in 0..<results!.count {
                if results?[index]["type"] as! String == "Trailer" {
                    self.trailerKey = (results?[index]["key"] as? String)!
                    break
                }
            }
            
        } failHandler: { httpStatusCode, errorMessage in
            print(errorMessage)
        }
    }
}
