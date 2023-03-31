//
//  ButtonUI.swift
//  TrueMovieFanIOS
//
//  Created by admin on 2023-03-31.
//

import UIKit

protocol ButtonUIDelegate{
    func  ButtonTapped( _ sender : ButtonUI )
}

class ButtonUI : UIButton{
    
    var delegate : ButtonUIDelegate?
    
    let imageIcon : UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .white
        img.clipsToBounds = true
        img.backgroundColor = .gray.withAlphaComponent(0)
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
        
    }()
    
    private let lblMesage : UILabel = {
        
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 18)
        lbl.backgroundColor = .gray.withAlphaComponent(0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
        
    }()
    
    
    public var img : UIImage?{
        didSet{
            imageIcon.image = img
        }
    }
    
    public var label : String? {
        didSet{
            lblMesage.text = label
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // adding subviews
        addSubview(imageIcon)
        addSubview(lblMesage)
                
        clipsToBounds = true //To prevent UI to go outside of the container
        
        // addTarget -> Connect the button as an action. (For this one: @IBAction Touch Up Inside Type)
        addTarget(self, action: #selector(btnTouchedUpInside), for: .touchUpInside)
        
    }
    
    @objc func btnTouchedUpInside() {
        
        
        if delegate != nil {
            delegate!.ButtonTapped(self)
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
    func addConstraints() {
        // Image Icon
        imageIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageIcon.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Label
        lblMesage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lblMesage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lblMesage.topAnchor.constraint(equalTo: imageIcon.bottomAnchor,constant: 2).isActive = true
        lblMesage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
}
