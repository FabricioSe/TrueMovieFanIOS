//
//  CellUI.swift
//  TrueMovieFanIOS
//
//  Created by admin on 2023-03-31.
//

import UIKit

class CellUI : UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    var coverImageView : UIImageView?
    var titleLabel : UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.contentView.backgroundColor = UIColor.blue
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createUI(){
        coverImageView = UIImageView.init(frame: CGRect(x: 15, y: 15, width: 100, height: 100))
        coverImageView?.contentMode = .scaleAspectFill
        coverImageView?.clipsToBounds = true
        self.contentView.addSubview(coverImageView!)
        
        titleLabel = UILabel.init(frame: CGRect(x: 130, y: 60, width: UIScreen.main.bounds.size.width - 145, height: 20))
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        titleLabel?.textColor = UIColor.black
        self.contentView.addSubview(titleLabel!)
    }
    
}

