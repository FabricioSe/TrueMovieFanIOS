//
//  ViewController.swift
//  TrueMovieFanIOS
//
//  Created by Fabricio Segovia on 2023-03-30.
//

import UIKit

class ViewController: UIViewController, ButtonPanelDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UISearchBarDelegate {
    
    //****** FROM API ********
    var trendingMovieList = [Movie]()
    var upcomingMovieList = [Movie]()
    var searchingMovieList = [Movie]()
    //************************
    
    var headTitle : String?{
        didSet{
            myTitle.text = headTitle
        }
    }
    
    var myTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Trending Movies"
        lbl.font = .boldSystemFont(ofSize: 35)
        lbl.textColor = .black
        return lbl
    }()
    
    var buttonBar : ButtonPanel = ButtonPanel()
    
    var tableView : UITableView = UITableView()
    
    var movieListTableView : UITableView = UITableView()
    
    var status : Bool = false
    
    var searchBar : UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Enter Movie Name"
        sb.isTranslucent = true
        return sb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        discoverMovies()
        upcomingMovies()

        self.view.addSubview(buttonBar)
        //self.view.backgroundColor = .gray
        self.view.addSubview(myTitle)
        self.view.addSubview(tableView)
        self.view.addSubview(searchBar)
        self.view.addSubview(movieListTableView)
        
        buttonBar.delegate = self
        searchBar.delegate = self
        
        tableView.register(CellUI.self, forCellReuseIdentifier: CellUI.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        movieListTableView.register(CellSearchingUI.self, forCellReuseIdentifier: CellSearchingUI.identifier)
        movieListTableView.delegate = self
        movieListTableView.dataSource = self

        applyConstraints()

    }

    func applyConstraints(){
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        buttonBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        buttonBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 60).isActive = true

        myTitle.translatesAutoresizingMaskIntoConstraints = false
        myTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 30).isActive = true
        myTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        myTitle.widthAnchor.constraint(equalToConstant: 400).isActive = true
        myTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: myTitle.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: buttonBar.topAnchor).isActive = true
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 15).isActive = true
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -15).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        movieListTableView.translatesAutoresizingMaskIntoConstraints = false
        movieListTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        movieListTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        movieListTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        movieListTableView.bottomAnchor.constraint(equalTo: buttonBar.topAnchor).isActive = true
        /*
        buttonBar.backgroundColor = .cyan
        myTitle.backgroundColor = .red
        tableView.backgroundColor = .yellow
        */
        searchBar.isHidden = true
        movieListTableView.isHidden = true
    }
    
    func nowButtonTapped(sender: ButtonPanel) {
        print("Trending")
        headTitle = "Trending Movies"
        searchBar.isHidden = true
        myTitle.isHidden = false
        tableView.isHidden = false
        status = false
        movieListTableView.isHidden = true
        tableView.reloadData()
    }
    
    func upComingButtonTapped(sender: ButtonPanel) {
        print("UP COMING")
        headTitle = "UpComing Movies"
        searchBar.isHidden = true
        myTitle.isHidden = false
        tableView.isHidden = false
        status = true
        movieListTableView.isHidden = true
        tableView.reloadData()
    }
    
    func searchButtonTapped(sender: ButtonPanel) {
        print("Search")
        headTitle = "Search"
        searchBar.isHidden = false
        tableView.isHidden = true
        myTitle.isHidden = true
        movieListTableView.isHidden = false
    }
    
    // Function coming from the API
    func discoverMovies() {
        tmdbAPI.page = 1
        tmdbAPI.discoverMovies {  httpStatusCode, response in
            let current = response as [String:Any]
            let results = current["results"] as? [[String:Any]]
            
            for index in 0..<results!.count {
                let finalResult = tmdbAPIMovies.decode(json: results![index])
                let movie = Movie(title: finalResult!.title, posterURL: "https://image.tmdb.org/t/p/w500\(finalResult!.poster_path)", id: finalResult!.id)
                self.trendingMovieList.append(movie)
            }
            //self.tableView.reloadData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } failHandler: { httpStatusCode, errorMessage in
            print(errorMessage)
        }
        
        tmdbAPI.page = 2
        tmdbAPI.discoverMovies {  httpStatusCode, response in
            let current = response as [String:Any]
            let results = current["results"] as? [[String:Any]]
            
            for index in 0..<results!.count {
                let finalResult = tmdbAPIMovies.decode(json: results![index])
                let movie = Movie(title: finalResult!.title, posterURL: "https://image.tmdb.org/t/p/w500\(finalResult!.poster_path)", id: finalResult!.id)
                self.trendingMovieList.append(movie)
            }
            //self.tableView.reloadData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } failHandler: { httpStatusCode, errorMessage in
            print(errorMessage)
        }
        
        tmdbAPI.page = 3
        tmdbAPI.discoverMovies {  httpStatusCode, response in
            let current = response as [String:Any]
            let results = current["results"] as? [[String:Any]]
            
            for index in 0..<results!.count {
                let finalResult = tmdbAPIMovies.decode(json: results![index])
                let movie = Movie(title: finalResult!.title, posterURL: "https://image.tmdb.org/t/p/w500\(finalResult!.poster_path)", id: finalResult!.id)
                self.trendingMovieList.append(movie)
            }
            //self.tableView.reloadData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } failHandler: { httpStatusCode, errorMessage in
            print(errorMessage)
        }

    }
    
    func upcomingMovies() {
        tmdbAPI.page = 1
        tmdbAPI.upcomingMovies { httpStatusCode, response in
            let current = response as [String:Any]
            let results = current["results"] as? [[String:Any]]
            
            for index in 0..<results!.count {
                let finalResult = tmdbAPIMovies.decode(json: results![index])
                let movie = Movie(title: finalResult!.title, posterURL: "https://image.tmdb.org/t/p/w500\(finalResult!.poster_path)", id: finalResult!.id)
                self.upcomingMovieList.append(movie)
            }
            //self.tableView.reloadData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } failHandler: { httpStatusCode, errorMessage in
            print(errorMessage)
        }
        
    }
    
    func searchMovie( movieName : String) {
        tmdbAPI.movieName = movieName
        tmdbAPI.searchMovie { httpStatusCode, response in
            let currentSearch = response as [String:Any]
            let results = currentSearch["results"] as? [[String:Any]]
            
            if results!.count != 0 {
                for index in 0..<results!.count {
                    let finalResult = tmdbAPIMovieSearch.decode(json: results![index])
                    let movie = Movie(title: finalResult!.title, id: finalResult!.id, release_date: String(finalResult!.release_date.prefix(4)))
                    print(movie.toString())
                    self.searchingMovieList.append(movie)
                }
                
                DispatchQueue.main.async {
                    self.movieListTableView.reloadData()
                }
            } else {
                self.searchingMovieList = []
            }
        } failHandler: { httpStatusCode, errorMessage in
            print(errorMessage)
        }
    }
    
    //TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == movieListTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellSearchingUI.identifier, for: indexPath) as! CellSearchingUI
            cell.movieName.text = self.searchingMovieList[indexPath.row].title
            cell.movieYear.text = self.searchingMovieList[indexPath.row].release_date
            //cell.textLabel?.text = self.searchingMovieList[indexPath.row].title
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellUI.identifier, for: indexPath) as! CellUI
            if status == true{
                cell.titleLabel?.text = self.upcomingMovieList[indexPath.row].title
                cell.coverImageView?.fetchUImageFromURL(url: URL(string: upcomingMovieList[indexPath.row].posterURL)!)
            }else{
                cell.titleLabel?.text = self.trendingMovieList[indexPath.row].title
                cell.coverImageView?.fetchUImageFromURL(url: URL(string: trendingMovieList[indexPath.row].posterURL)!)
            }
            return cell
        }
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if tableView == movieListTableView{
            return 50
        }else{
            return 130
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == movieListTableView{
            return self.searchingMovieList.count
        }else{
            if status == true{
                return self.upcomingMovieList.count
            }
            else{
                return self.trendingMovieList.count
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)

        if tableView == movieListTableView{
            let selectedMovie = searchingMovieList[indexPath.row]
            let infoVC = MovieInfoViewController()
            infoVC.selectedMovie = selectedMovie.id
            present(infoVC, animated: true)
        }else{
            let infoVC = MovieInfoViewController()
            
            if status == false{
                let selectedMovie = trendingMovieList[indexPath.row]
                infoVC.selectedMovie = selectedMovie.id
            }else{
                let selectedMovie = upcomingMovieList[indexPath.row]
                infoVC.selectedMovie = selectedMovie.id
            }
            
            present(infoVC, animated: true)
            //        navigationController?.pushViewController(infoVC, animated: true)
        }
    }
     
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchingMovieList = []
        searchMovie(movieName: searchBar.text!)
    }
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if searchBar.canBecomeFirstResponder {
            searchBar.becomeFirstResponder()
            searchingMovieList = []
            searchMovie(movieName: searchBar.text!)
        }
    }
     */
}

