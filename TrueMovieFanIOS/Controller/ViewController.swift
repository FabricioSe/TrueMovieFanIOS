//
//  ViewController.swift
//  TrueMovieFanIOS
//
//  Created by Fabricio Segovia on 2023-03-30.
//

import UIKit

class ViewController: UIViewController, ButtonPanelDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    //********* FROM API
    var arrayOfMoviesName = [String]()
    var arrayOfMoviePoster = [String]()
    //
    
    var headTitle : String?{
        didSet{
            myTitle.text = headTitle
        }
    }
    
    var datasource = ["ios 1","ios 2"]
    
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
        
        self.view.addSubview(buttonBar)
        //self.view.backgroundColor = .gray
        self.view.addSubview(myTitle)
        self.view.addSubview(tableView)
        self.view.addSubview(searchBar)
        
        buttonBar.delegate = self
        
        
        tableView.register(CellUI.self, forCellReuseIdentifier: CellUI.identifier)

        tableView.delegate = self
        tableView.dataSource = self
        
        
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
        
        buttonBar.backgroundColor = .cyan
        myTitle.backgroundColor = .red
        tableView.backgroundColor = .yellow
        
        searchBar.isHidden = true
    }
    
    func nowButtonTapped(sender: ButtonPanel) {
        print("Trending")
        headTitle = "Trending Movies"
        searchBar.isHidden = true
        myTitle.isHidden = false
        tableView.isHidden = false
    }
    
    func upComingButtonTapped(sender: ButtonPanel) {
        print("UP COMING")
        headTitle = "Up Coming Movies"
        searchBar.isHidden = true
        myTitle.isHidden = false
        tableView.isHidden = false
    }
    
    func searchButtonTapped(sender: ButtonPanel) {
        print("Search")
        headTitle = "Search"
        searchBar.isHidden = false
        //tableView.isHidden = true
        myTitle.isHidden = true
        
    }
    
    // Function coming from the API
    func discoverMovies() {
        tmdbAPI.discoverMovies {  httpStatusCode, response in
            let current = response as [String:Any]
            let results = current["results"] as? [[String:Any]]
            
            for index in 0..<results!.count {
                let finalResult = tmdbAPIMovies.decode(json: results![index])
                DispatchQueue.main.async {
                    self.arrayOfMoviesName.append(finalResult!.title)
                    self.arrayOfMoviePoster.append("https://image.tmdb.org/t/p/w500\(finalResult!.poster_path)")
                }
            }
        } failHandler: { httpStatusCode, errorMessage in
            print(errorMessage)
        }
    }
    
    //TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellUI.identifier, for: indexPath) as! CellUI
        cell.titleLabel?.text = datasource[indexPath.row]
        return cell
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

