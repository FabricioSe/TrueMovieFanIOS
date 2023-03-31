//
//  ButtonPanel.swift
//  TrueMovieFanIOS
//
//  Created by admin on 2023-03-30.
//

import UIKit

protocol ButtonPanelDelegate {
    
    func nowButtonTapped(sender : ButtonPanel)
    func upComingButtonTapped(sender : ButtonPanel)
    func searchButtonTapped(sender : ButtonPanel)
    
}


class ButtonPanel : UIView, ButtonUIDelegate {

    var delegate : ButtonPanelDelegate?
    
    var nowButton : ButtonUI = ButtonUI()
    var upComingButton : ButtonUI = ButtonUI()
    var searchButton : ButtonUI = ButtonUI()
    
    var studentList : [String] = []
    
    @IBOutlet var tableView : UITableView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // adding subviews
        addSubview(nowButton)
        addSubview(upComingButton)
        addSubview(searchButton)
        
        nowButton.delegate = self
        upComingButton.delegate = self
        searchButton.delegate = self
        
                
        clipsToBounds = true //To prevent UI to go outside of the container
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        nowButton.img = UIImage(systemName: "film")
        nowButton.label = "Trending"

        upComingButton.img = UIImage(systemName: "film.stack")
        upComingButton.label = "UpComing"
        
        searchButton.img = UIImage(systemName: "magnifyingglass")
        searchButton.label = "Search"
        
        addConstraints()
    }
    
    func addConstraints(){
        
        //Center
        upComingButton.translatesAutoresizingMaskIntoConstraints = false
        upComingButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        upComingButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        upComingButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        //Left
        nowButton.translatesAutoresizingMaskIntoConstraints = false
        nowButton.trailingAnchor.constraint(equalTo: upComingButton.leadingAnchor, constant: -20).isActive = true
        nowButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nowButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        //Right
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.leadingAnchor.constraint(equalTo: upComingButton.trailingAnchor, constant: 20).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }

    func ButtonTapped(_ sender: ButtonUI) {
        if sender == nowButton {
            if delegate != nil {
                delegate!.nowButtonTapped(sender: self)
            }
        }

        if sender == upComingButton {
            if delegate != nil {
                delegate!.upComingButtonTapped(sender: self)
            }
        }

        if sender == searchButton {
            if delegate != nil {
                delegate!.searchButtonTapped(sender: self)
            }
        }
    }
    
}
