//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use Autolayout to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and Good luck. - Rapptr Labs
     * =========================================================================================
     */
    
    // MARK: - Outlets
    var chatButton: UIButton = MenuButton(text: "CHAT")
    var loginButton: UIButton = MenuButton(text: "LOGIN")
    var animationButton: UIButton = MenuButton(text: "ANIMATION")
    
    var navBar: UINavigationBar = NavBar(text: "Coding Tasks")
    
    var sv = UIStackView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_home_menu")!)
        
        view.addSubview(navBar)
        
        setupButtons()
        setupStackView()
        
    }
    
    func setupButtons() {
        chatButton.setImage(UIImage(named: "ic_chat"), for: .normal)
        chatButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        
        loginButton.setImage(UIImage(named: "ic_login"), for: .normal)
        loginButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        
        animationButton.setImage(UIImage(named: "ic_animation"), for: .normal)
        animationButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        
        chatButton.addTarget(self, action: #selector(didPressChatButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
        animationButton.addTarget(self, action: #selector(didPressAnimationButton), for: .touchUpInside)
    }
    
    
    fileprivate func setupStackView() {
        sv = UIStackView(arrangedSubviews: [chatButton, loginButton, animationButton])
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.axis = .vertical
        sv.spacing = UIScreen.main.bounds.height / 24
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(sv)
        
        sv.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: UIScreen.main.bounds.height/3).isActive = true
        sv.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sv.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -1 * (UIScreen.main.bounds.height/3)) .isActive = true
        
    }
    
    // MARK: - Actions
    @objc func didPressChatButton() {
        let chatViewController = ChatViewController()
        chatViewController.modalPresentationStyle = .fullScreen
        navBar.isHidden = true
        self.present(chatViewController, animated: true, completion: nil)
    }
    
    @objc func didPressLoginButton() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        navBar.isHidden = true
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    @objc func didPressAnimationButton() {
        let animationViewController = AnimationViewController()
        animationViewController.modalPresentationStyle = .fullScreen
        navBar.isHidden = true
        self.present(animationViewController, animated: true, completion: nil)
    }
}
