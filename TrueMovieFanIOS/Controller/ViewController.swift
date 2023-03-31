//
//  ViewController.swift
//  TrueMovieFanIOS
//
//  Created by Fabricio Segovia on 2023-03-30.
//

import UIKit

class ViewController: UIViewController, ButtonPanelDelegate {
    
    var headTitle : String?{
        didSet{
            myTitle.text = headTitle
        }
    }
    
    var myTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Now Playing"
        lbl.font = .boldSystemFont(ofSize: 35)
        lbl.textColor = .black
        return lbl
    }()
    
    var buttonBar : ButtonPanel = ButtonPanel()
    
    var tableView : UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(buttonBar)
        self.view.backgroundColor = .gray
        self.view.addSubview(myTitle)
        self.view.addSubview(tableView)
        buttonBar.delegate = self
        
        
        tableView.register(CellUI.self, forCellReuseIdentifier: "cellUI")

        
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
        myTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: myTitle.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: buttonBar.topAnchor).isActive = true
        
        buttonBar.backgroundColor = .cyan
        myTitle.backgroundColor = .red
        tableView.backgroundColor = .yellow
    }
    
    func nowButtonTapped(sender: ButtonPanel) {
        print("Trending")
        headTitle = "Trending Movies"
    }
    
    func upComingButtonTapped(sender: ButtonPanel) {
        print("UP COMING")
        headTitle = "Up Coming Movies"
    }
    
    func searchButtonTapped(sender: ButtonPanel) {
        print("Search")
        headTitle = "Search"

    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    

}

