//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     **/
    
    var navBar: UINavigationBar = NavBar(text: "Animation")
    var imageView: UIImageView = UIImageView(image: UIImage(named: "ic_logo"))
    var fade: UIButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        setUpImageView()
        setUpButton()
        setBackButton()
        view.addSubview(navBar)
        view.addSubview(fade)
    }
    
    func setUpImageView() {
        //let imageView = UIImageView(image: UIImage(named: "ic_logo"))
        imageView.frame = CGRect(x: UIScreen.main.bounds.width/8, y: (UIScreen.main.bounds.height*2)/7, width: (UIScreen.main.bounds.width*3)/4, height: UIScreen.main.bounds.height/10)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDrag(recognizer:))))
        view.addSubview(imageView)
        
    }
    
    func setUpButton() {
        fade.frame = CGRect(x: UIScreen.main.bounds.width/11, y: (UIScreen.main.bounds.height*8)/9, width: (UIScreen.main.bounds.width*9)/11, height: UIScreen.main.bounds.height/15)
        fade.backgroundColor = UIColor(red: 14/255, green: 92/255, blue: 137/255, alpha: 1)
        fade.setTitle("FADE OUT", for: .normal)
        fade.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        fade.titleLabel?.textColor = .white
        fade.addTarget(self, action: #selector(didPressFade), for: .touchUpInside)
        view.addSubview(fade)
    }
    
    func setBackButton() {
        //let item = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(backAction))
        
        navBar.items![0].leftBarButtonItem = UIBarButtonItem(
            title: "<", style: .plain, target: self, action: #selector(backAction))
        //navBar.items![0].leftBarButtonItem.font
    }
    
    // MARK: - Actions
    @objc func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        mainMenuViewController.modalPresentationStyle = .fullScreen
        navBar.isHidden = true
        self.present(mainMenuViewController, animated: true, completion: nil)
    }
    
    @objc func handleDrag(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        recognizer.setTranslation(CGPoint.zero, in: view)
            print(translation)

        let label = recognizer.view as! UIImageView
        label.center = CGPoint(x: label.center.x+translation.x, y: label.center.y+translation.y)
        label.isMultipleTouchEnabled = true
        label.isUserInteractionEnabled = true
    }
    
    @objc func didPressFade(_ sender: Any) {
        if(self.imageView.alpha == 0) {
            UIView.animate(withDuration: 1.5) {
                self.imageView.alpha = 1
                }
            self.fade.setTitle("FADE OUT", for: .normal)
        }else {
            UIView.animate(withDuration: 1.5) {
                self.imageView.alpha = 0
                }
            self.fade.setTitle("FADE IN", for: .normal)
        }
        
        
    }
   
}
