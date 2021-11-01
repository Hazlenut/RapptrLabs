//
//  LoginFields.swift
//  iOSTest
//
//  Created by William Wung on 5/18/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

class LoginFields: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    required init(textField: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width * 3)/4)).isActive = true
        heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/8).isActive = true
        placeholder = textField
        bounds.inset(by: padding)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
