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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(buttonBar)
        self.view.backgroundColor = .gray
        self.view.addSubview(myTitle)
        buttonBar.delegate = self
        
        applyConstraints()
    }

    func applyConstraints(){
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        buttonBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        buttonBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 60).isActive = true

        
        myTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 30).isActive = true
        myTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        myTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonBar.backgroundColor = .cyan
        myTitle.backgroundColor = .red
    }
    
    func nowButtonTapped(sender: ButtonPanel) {
        print("Now")
        headTitle = "Now Playing"
    }
    
    func upComingButtonTapped(sender: ButtonPanel) {
        print("UP COMING")
        headTitle = "Up Coming"
    }
    
    func searchButtonTapped(sender: ButtonPanel) {
        print("Search")
        headTitle = "Search"

    }

    
    
    

}

