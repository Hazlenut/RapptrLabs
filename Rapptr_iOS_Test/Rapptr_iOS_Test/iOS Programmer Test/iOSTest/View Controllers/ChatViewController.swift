//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Using the following endpoint, fetch chat data
     *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model
     *
     **/
    
    // MARK: - Properties
    private var client: ChatClient?
    private var messages: [Message]?
    var label: UILabel?
    var json1: NSDictionary?
    var navBar: UINavigationBar = NavBar(text: "Chat")
    var safeArea: UILayoutGuide!
    typealias Finish = ()->()
    // MARK: - Outlets
    var chatTable: UITableView = UITableView()
    
    var cont: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages = [Message]()
        request()
        // TODO: Remove test data when we have actual data from the server loaded
        /*
        messages?.append(Message(testName: "James", withTestMessage: "Hey Guys!"))
        messages?.append(Message(testName:"Paul", withTestMessage:"What's up?"))
        messages?.append(Message(testName:"Amy", withTestMessage:"Hey! :)"))
        messages?.append(Message(testName:"James", withTestMessage:"Want to grab some food later?"))
        messages?.append(Message(testName:"Paul", withTestMessage:"Sure, time and place?"))
        messages?.append(Message(testName:"Amy", withTestMessage:"YAS! I am starving!!!"))
        messages?.append(Message(testName:"James", withTestMessage:"1 hr at the Local Burger sound good?"))
        messages?.append(Message(testName:"Paul", withTestMessage:"Sure thing"))
        messages?.append(Message(testName:"Amy", withTestMessage:"See you there :P"))
        */
        chatTable.reloadData()
    }

    func setBackButton() {
        navBar.items![0].leftBarButtonItem = UIBarButtonItem(
            title: "<", style: .plain, target: self, action: #selector(backAction))
        //navBar.items![0].leftBarButtonItem.font
    }
    
    
    func addMessages() {
        let valuesArray: NSArray? = json1?.object(forKey: "data") as? NSArray
        print("HERE")
        if let valuesArray = valuesArray {
            print("THERE")
            for (item) in valuesArray {
                messages?.append(Message(name: (item as! NSDictionary).object(forKey: "name") as? String, initWithMessage: (item as! NSDictionary).object(forKey: "message") as? String, initWithUserID: (item as! NSDictionary).object(forKey: "user_id") as? String, initWithAvatarURL: (item as! NSDictionary).object(forKey: "avatar_url") as? String))
            }
        }
        DispatchQueue.main.async {
            self.safeArea = self.view.layoutMarginsGuide
            //chatTable = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            self.setUpTableView()
            //configureTable(tableView: chatTable)
            //request()
            self.setBackButton()
            self.view.addSubview(self.navBar)
        }
        
    }
    func request() {
        var req = URLRequest(url: URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php")!)
        req.httpMethod = "POST"
        let post = "numQue"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = post.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: req) { [self] data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary

                if let parseJSON = json {
                    self.json1 = parseJSON
                    //print(parseJSON)
                    self.addMessages()
                    print("LOL")
                    return
                }
            } catch {
                print(" error:\(error)")
            }
        }
        task.resume()
    }
    

    
    func setUpTableView() {
        view.addSubview(chatTable)
        chatTable.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        chatTable.separatorColor = .white
        
        chatTable.translatesAutoresizingMaskIntoConstraints = false
        
        chatTable.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: UIScreen.main.bounds.height/25).isActive = true
        chatTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        chatTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        chatTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        chatTable.delegate = self
        chatTable.dataSource = self
        chatTable.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
    }
    
    // MARK: - Private
  /*
    private func configureTable(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        tableView.tableFooterView = UIView(frame: .zero)
        //view.addSubview(tableView)
    }
    */
    

    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatTableViewCell? = nil
        if cell == nil {
            let nibs = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)
            cell = nibs?[0] as? ChatTableViewCell
        }
        cell?.setCellData(message: messages![indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages!.count
    }
   
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    // MARK: - IBAction
    @objc func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        mainMenuViewController.modalPresentationStyle = .fullScreen
        navBar.isHidden = true
        self.present(mainMenuViewController, animated: true, completion: nil)
    }
}

