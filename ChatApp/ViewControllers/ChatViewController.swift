//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Isaac Samuel on 10/5/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "ChatApp"
    }
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var messages = [PFObject]()
    var refreshControl: UIRefreshControl!
    //let welcomeMessage = labelWelcome.text

    
    @IBAction func sendMessageButton(_ sender: Any) {
        let Chatmessage = chatMessageField.text ?? ""
        let currentUser = PFUser.current()!
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = Chatmessage
        chatMessage["user"] = currentUser
        
        chatMessage.saveInBackground{(success: Bool, error: Error?) in
            if (success){
                print("The message was saved Successfully by \(currentUser)")
                self.messages.append(chatMessage)
                self.tableView.reloadData()
                self.chatMessageField.text = ""
            }
            else if let error = error{
                let errorAlertController = UIAlertController(title: "Problem saving message", message: "Please, Check your internet Connection", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
                print(error.localizedDescription) }
            /*
            else if let error = error{
                print("Problem saving message: \(error.localizedDescription)")
            }*/
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "ChatApp"
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        //activityIndicator.stopAnimating()
        if let currentUser = PFUser.current() {
            //activityIndicator.stopAnimating()
            //print("Welcome back \(currentUser.username!) 😀")
             labelWelcome.text = "Welcome back \(currentUser.username!) 😀"
                
                // TODO: Load Chat view controller and set as root view controller
            
        }else {
            let user = PFUser()
            labelWelcome.text = "Welcome \(user)"
        }
        self.tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className: "Message")
        //query.order(byDescending: "createdAt")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects:[PFObject]?, error: Error?) -> Void in
            if error==nil{
                print("successfully retrieved \(objects!.count) messages")
                
                self.messages = objects!
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                
            }
            else{
                self.activityIndicator.stopAnimating()
                print("downloaded chat")
                self.messages = objects!
                self.tableView.reloadData()
            }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messages.count;

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let chatMessage = messages[indexPath.row]
        cell.labelMessage.layer.cornerRadius = 10.0
        
        if let user = chatMessage["user"] as? PFUser {
            // User found! update username label with username
            cell.labelUser.text = user.username!+":"
        } else {
            // No user found, set default username
            cell.labelUser.text = "🤖"
        }
        cell.labelMessage.text = (chatMessage["text"] as! String)
        return cell

    }
    

}
