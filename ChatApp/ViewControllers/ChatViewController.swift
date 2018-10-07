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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatMessageField: UITextField!
    
    var messages = [PFObject]()
    
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
                
            }else if let error = error{
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        /*Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)*/
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func onTimer() {
        // Add code to be run periodically
        
        
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects:[PFObject]?, error: Error?) -> Void in
            if error==nil{
                print("successfully retrieved \(objects!.count) messages")
                
                self.messages = objects!
            }
            else{
                print("downloaded chat")
                self.messages = objects!
                self.tableView.reloadData()
            }
            }
    }
    /*func onTimer(){
        
        var query = PFQuery(className:"Message")
        query.findObjectsInBackground { (objects:[PFObject]?, error: Error?) -> Void in
            if error==nil{
                print("successfully retrieved \(objects!.count) messages")
                
                self.messages = objects!
            }
            else{
                
            }
            
        }
    }*/
    /*
    @objc func onTimer() {
        //code to be run periodically
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messages.count;

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let chatMessage = messages[indexPath.row]
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
