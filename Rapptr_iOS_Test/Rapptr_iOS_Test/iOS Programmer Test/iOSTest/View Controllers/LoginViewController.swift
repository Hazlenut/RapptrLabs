//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    var loginField: UITextField = LoginFields(textField: "Username")
    var passwordField: UITextField = LoginFields(textField: "Password")
    var loginButton: UIButton = UIButton()
    
    var num: Int!
    
    
    
    
    var sv = UIStackView()
    
    // MARK: - Properties
    private var client: LoginClient?
    var navBar: UINavigationBar = NavBar(text: "Login")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "img_login")!)
        setBackButton()
        view.addSubview(navBar)
        setupButtons()
        setupStackView()
        //setUpAlert()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
      //setUpAlert(num: num)
    }
    func setBackButton() {
        navBar.items![0].leftBarButtonItem = UIBarButtonItem(
            title: "<", style: .plain, target: self, action: #selector(backAction))
        //navBar.items![0].leftBarButtonItem.font
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupButtons() {
        loginField.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.5)
        
        loginButton.backgroundColor = UIColor(red: 14/255, green: 92/255, blue: 137/255, alpha: 1)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width * 3)/4)).isActive = true
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.titleLabel?.textAlignment = .center
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        
        passwordField.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.5)
        passwordField.isSecureTextEntry = true
        
        loginButton.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
    }
    
    fileprivate func setupStackView() {
        sv = UIStackView(arrangedSubviews: [loginField, passwordField, loginButton])
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.axis = .vertical
        sv.spacing = UIScreen.main.bounds.height / 24
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(sv)
        
        sv.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: UIScreen.main.bounds.height/7).isActive = true
        sv.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sv.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: (-1 * (UIScreen.main.bounds.height * 4)/7)) .isActive = true
        
    }
    
    @IBAction func setUpAlert(num: Int) {
        DispatchQueue.main.async {
        if(num == 1) {
            let alertError: UIAlertController = UIAlertController(title: "Error", message: "Username and password not found.", preferredStyle: .alert)
                alertError.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertError, animated: true, completion: nil)
    
        }else{
            let alertSuccess: UIAlertController = UIAlertController(title: "Welcome back!", message: "Please click below to be redirected.", preferredStyle: .alert)
            alertSuccess.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in self.backAction()}))
                self.present(alertSuccess, animated: true, completion: nil)
        }
        }
    }
    
    // MARK: - Actions
    @objc func backAction() {
        let mainMenuViewController = MenuViewController()
        mainMenuViewController.modalPresentationStyle = .fullScreen
        navBar.isHidden = true
        self.present(mainMenuViewController, animated: true, completion: nil)
    }
    
    @objc func pressedLogin() {
        
    }
    
    @objc func didPressLoginButton(_ sender: Any) {
        let userName = self.loginField.text!
        let password = self.passwordField.text!
        let postData = "username=\(userName)&password=\(password)".data(using: .utf8)
        let req = NSMutableURLRequest(url: NSURL(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php")! as URL)
        req.httpMethod = "POST"
        req.httpBody = postData
        let task = URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                self.setUpAlert(num: 1)
                self.num = 1
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            self.setUpAlert(num: 0)
            self.num = 0
        }

        task.resume()
        
    }
}
