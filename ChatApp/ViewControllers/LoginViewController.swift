//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Isaac Samuel on 10/5/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse



class LoginViewController: UIViewController {
    

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var AcitivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ChatApp"
        // Do any additional setup after loading the view.
        AcitivityIndicator.stopAnimating()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        self.AcitivityIndicator.startAnimating()
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            
            if username.isEmpty{
                let OKAction = UIAlertAction(title: "OK", style: .default){(action) in}
                let alertController = UIAlertController(title: "Username Failed!", message: "Please Enter your Username.", preferredStyle: .alert)
                
                self.present(alertController, animated: true, completion: nil)
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.AcitivityIndicator.stopAnimating()
                
            }
            else if password.isEmpty{
                let OKAction = UIAlertAction(title: "OK", style: .default){(action) in}
                let alertController = UIAlertController(title: "Password Failed!", message: "Please Enter your Password.", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.AcitivityIndicator.stopAnimating()
            }
            else{
                if let error = error{
                    let errorAlertController = UIAlertController(title: "User Log in Failed!", message: "Plese, Verify your username and password or Check your internet Connection", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                    errorAlertController.addAction(cancelAction)
                    self.present(errorAlertController, animated: true)
                    print(error.localizedDescription)
                    self.AcitivityIndicator.stopAnimating()
                    
 
                }else {
                    self.AcitivityIndicator.startAnimating()
                    print("Login Success")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    
                }
            }
        }
    }
    
    @IBAction func onSignUpButton(_ sender: Any) {

    }
    


}
