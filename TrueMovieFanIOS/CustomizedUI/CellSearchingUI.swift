//
//  CellSearchingUI.swift
//  TrueMovieFanIOS
//
//  Created by Jiarui Li on 2023-04-11.
//

import UIKit

class CellSearchingUI : UITableViewCell{
    
    static let identifier = "SearchingMovieListCell"
    
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
    
}
