//
//  CellSearchingUI.swift
//  TrueMovieFanIOS
//
//  Created by Jiarui Li on 2023-04-11.
//

import UIKit

class CellSearchingUI : UITableViewCell{
    
    static let identifier = "SearchingMovieListCell"
    
    let movieName = UILabel()
    let movieYear = UILabel()
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           // Set any attributes of your UI components here.
           movieName.translatesAutoresizingMaskIntoConstraints = false
           movieYear.translatesAutoresizingMaskIntoConstraints = false
           movieName.font = UIFont.systemFont(ofSize: 15)
           movieYear.font = UIFont.systemFont(ofSize: 15)
           movieYear.textColor = .systemBlue
           
           // Add the UI components
           contentView.addSubview(movieName)
           contentView.addSubview(movieYear)
           
           NSLayoutConstraint.activate([
            movieName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieName.widthAnchor.constraint(equalToConstant: 280),
            movieName.heightAnchor.constraint(equalToConstant: 50),
            
            movieYear.leadingAnchor.constraint(equalTo: movieName.trailingAnchor, constant: 20),
            movieYear.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieYear.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieYear.heightAnchor.constraint(equalToConstant: 50),
           ])
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    /*
    var movieName : UILabel?
    var movieYear : UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.contentView.backgroundColor = UIColor.blue
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createUI(){
        
        movieName = UILabel.init(frame: CGRect(x: 130, y: 60, width: UIScreen.main.bounds.size.width - 145, height: 20))
        movieName?.font = UIFont.systemFont(ofSize: 20)
        movieName?.textColor = UIColor.black
        self.contentView.addSubview(movieName!)
        
        movieYear = UILabel.init(frame: CGRect(x: 330, y: 60, width: UIScreen.main.bounds.size.width - 145, height: 20))
        movieYear?.font = UIFont.systemFont(ofSize: 20)
        movieYear?.textColor = UIColor.black
        self.contentView.addSubview(movieYear!)
         
    }
     */
    
}
