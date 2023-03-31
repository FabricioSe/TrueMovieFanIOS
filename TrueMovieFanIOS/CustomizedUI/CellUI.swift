//
//  CellUI.swift
//  TrueMovieFanIOS
//
//  Created by admin on 2023-03-31.
//

import UIKit

class CellUI : UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // /// ///
    let img : UIImageView = {
        let i = UIImageView()
        //i.images = UIImage(systemName: "")
        i.contentMode = .scaleAspectFit
        i.tintColor = .white
        i.clipsToBounds = true
        i.backgroundColor = .gray.withAlphaComponent(0)
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    
}

