//
//  ViewController.swift
//  TrueMovieFanIOS
//
//  Created by Fabricio Segovia on 2023-03-30.
//

import UIKit

class ViewController: UIViewController, ButtonPanelDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    //****** FROM API ********
    struct Movie {
        var title : String
        var posterURL : String
        var id : Int
    }
    
    var trendingMovieList = [Movie]()
    var upcomingMovieList = [Movie]()
    //************************
    
    var headTitle : String?{
        didSet{
            myTitle.text = headTitle
        }
    }
    
    var myTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Trening Movies"
        lbl.font = .boldSystemFont(ofSize: 35)
        lbl.textColor = .black
        return lbl
    }()
    
    var buttonBar : ButtonPanel = ButtonPanel()
    
    var tableView : UITableView = UITableView()
    
    var status : Bool = false
    
    var searchBar : UITextField = {
        let sb = UITextField()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Enter Movie Name"
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
        
        buttonBar.delegate = self
        
        
        tableView.register(CellUI.self, forCellReuseIdentifier: CellUI.identifier)

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
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
        searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 30).isActive = true
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: 30).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        /*
        buttonBar.backgroundColor = .cyan
        myTitle.backgroundColor = .red
        tableView.backgroundColor = .yellow
        */
        searchBar.isHidden = true
    }
    
    func nowButtonTapped(sender: ButtonPanel) {
        print("Trending")
        headTitle = "Trending Movies"
        searchBar.isHidden = true
        myTitle.isHidden = false
        tableView.isHidden = false
        status = false
        tableView.reloadData()
    }
    
    func upComingButtonTapped(sender: ButtonPanel) {
        print("UP COMING")
        headTitle = "UpComing Movies"
        searchBar.isHidden = true
        myTitle.isHidden = false
        tableView.isHidden = false
        status = true
        tableView.reloadData()
    }
    
    func searchButtonTapped(sender: ButtonPanel) {
        print("Search")
        headTitle = "Search"
        searchBar.isHidden = false
        tableView.isHidden = true
        myTitle.isHidden = true
        
    }
    
    // Function coming from the API
    func discoverMovies() {
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
    
    //TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if status == true{
            return self.upcomingMovieList.count
        }
        else{
            return self.trendingMovieList.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = trendingMovieList[indexPath.row]
        
        let infoVC = MovieInfoViewController()
        infoVC.selectedMovie = selectedMovie.id
        present(infoVC, animated: true)
//        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    
    
    
    
    
    
    //Search Bar
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        searchMovie()
        return true
    }
    
    func searchMovie(){
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, !text.isEmpty else{
            return
        }
        
        URLSession.shared.dataTask(with: URL(string: "")!, completionHandler: {
            data, response, error in
            
            guard let data = data, error == nil else{
                return
            }
            
            //Convert
            
            //Update our movie
            
            //Refresh
            
        }).resume()
                
    }
}

