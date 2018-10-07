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
    //@IBOutlet weak var labelMessage: UILabel!
    
    var messages = [PFObject]()
    
    @IBAction func sendMessageButton(_ sender: Any) {
        let Chatmessage = chatMessageField.text ?? ""
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = Chatmessage
        
        chatMessage.saveInBackground{(success: Bool, error: Error?) in
            if (success){
                print("The message was saved Successfully")
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messages.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let chatMessage = messages[indexPath.row]
        cell.labelMessage.text = (chatMessage["text"] as! String)
        
        return cell
    }


}
