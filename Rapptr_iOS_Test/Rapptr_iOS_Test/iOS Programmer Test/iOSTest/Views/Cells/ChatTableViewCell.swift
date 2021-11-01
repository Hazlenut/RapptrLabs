//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    var avatar: UIImageView = UIImageView()
    //var avatar: UIImage!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        header.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        
        header.frame = CGRect(x: contentView.bounds.width/5, y: 0, width: (contentView.bounds.width * 3)/4, height: contentView.bounds.height/4)
        //body.frame = CGRect(x: contentView.bounds.width/5, y: (contentView.bounds.height * 4)/8, width: (contentView.bounds.width * 3)/4, height: (contentView.bounds.height * 3)/4)
        avatar.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width/6, height: contentView.bounds.height / 1.25)
        
        body.backgroundColor = .white
        body.layer.cornerRadius = 0.5
        body.font = UIFont.systemFont(ofSize: 15)
        body.lineBreakMode = .byWordWrapping
        body.numberOfLines = 0
        body.sizeToFit()
        
        body.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (contentView.bounds.height * 4)/8).isActive = true
        body.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.bounds.width/5).isActive = true
        body.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1 * contentView.bounds.width/8).isActive = true
        
        header.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        header.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.bounds.width/5).isActive = true
        header.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
        
        
        contentView.addSubview(header)
        contentView.addSubview(body)
        contentView.addSubview(avatar)
        
    }
    
    // MARK: - Public
    func setCellData(message: Message) {
        header.text = message.username
        body.text = message.text
        let data = try? Data(contentsOf: message.avatarURL)
        avatar.image = UIImage(data: data!)!
        //body.adjustsFontSizeToFitWidth = true
        body.sizeToFit()
    }
    
}
