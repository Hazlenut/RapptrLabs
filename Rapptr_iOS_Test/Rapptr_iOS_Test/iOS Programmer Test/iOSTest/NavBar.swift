//
//  NavBar.swift
//  iOSTest
//
//  Created by William Wung on 5/17/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

class NavBar: UINavigationBar {
    required init(text: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height*12)/8))
        let item = UINavigationItem(title:  text)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        titleTextAttributes = textAttributes
        setItems([item], animated: false)
        barTintColor = UIColor(red: 14/255, green: 92/255, blue: 137/255, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
