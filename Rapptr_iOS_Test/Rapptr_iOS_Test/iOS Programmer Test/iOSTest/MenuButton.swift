//
//  MenuButton.swift
//  iOSTest
//
//  Created by William Wung on 5/15/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

class MenuButton: UIButton {
    required init(text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = UIColor(white: 1, alpha: 0.8)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        clipsToBounds = true
        layer.cornerRadius = 10
        contentHorizontalAlignment = .left
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width * 3)/4)).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
