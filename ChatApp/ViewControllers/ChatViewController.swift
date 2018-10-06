//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Isaac Samuel on 10/5/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    var messages = [PFObject]()
    
    @IBAction func sendMessageButton(_ sender: Any) {
        let Chatmessage = chatMessageField.text ?? ""
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = Chatmessage
        
        chatMessage.saveInBackground{(success: Bool, error: Error?) in
            if (success){
                print("The message was saved Successfully")
                self.messages.append(chatMessage)
            }else if let error = error{
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
