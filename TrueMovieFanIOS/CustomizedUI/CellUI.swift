//
//  CellUI.swift
//  TrueMovieFanIOS
//
//  Created by admin on 2023-03-31.
//

import UIKit

class CellUI : UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    public var movieImage : UIImage?{
        didSet{
            img.image = movieImage
        }
    }

    public var movieName : String?{
        didSet{
            name.text = movieName
        }
    }
    
    //2 movies in 1 row
    /*
    var vGridImages : [[UIImageView]] = [[createImage(imageName: "film"),createImage(imageName: "film")]]
    var vGridNames : [[UILabel]] = [[createNewLabel(text: "Movie Name"),createNewLabel(text: "Movie Name2")]]
    
    public static func createImage(imageName : String) -> UIImageView {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .white
        img.image = UIImage(systemName: imageName)
        img.clipsToBounds = true
        img.backgroundColor = .gray.withAlphaComponent(0)
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }
    
    public static func createNewLabel(text : String) -> UILabel {
        
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = text
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 18)
        lbl.backgroundColor = .gray.withAlphaComponent(0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }
     */
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(img)
        addSubview(name)
                
        clipsToBounds = true //To prevent UI to go outside of the container
        
        // addTarget -> Connect the button as an action. (For this one: @IBAction Touch Up Inside Type)
       // addTarget(self, action: #selector(movieTouchedUpInside), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // /// ///
    let img : UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "film")
        i.contentMode = .scaleAspectFit
        i.tintColor = .white
        i.clipsToBounds = true
        i.backgroundColor = .gray.withAlphaComponent(0)
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    let name : UILabel = {
        let n = UILabel()
        n.text = "Movie Name"
        n.textColor = .black
        n.contentMode = .scaleAspectFit
        n.clipsToBounds = true
        n.translatesAutoresizingMaskIntoConstraints = false
        return n
    }()
    
    
    @objc func movieTouchedUpInside() {
        
        /*
        if delegate != nil {
            delegate!.ButtonTapped(self)
        }
         */
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
    func addConstraints() {
        // Image Icon
        img.translatesAutoresizingMaskIntoConstraints = false
        img.centerXAnchor.constraint(equalToSystemSpacingAfter: self.centerXAnchor, multiplier: 0.5).isActive = true
        img.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        img.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        // Label
        name.translatesAutoresizingMaskIntoConstraints = false
        name.centerXAnchor.constraint(equalToSystemSpacingAfter: self.centerXAnchor, multiplier: 0.5).isActive = true
        name.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2).isActive = true
        name.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
}

