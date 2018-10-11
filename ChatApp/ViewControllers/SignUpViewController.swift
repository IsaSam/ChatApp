//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by Isaac Samuel on 10/11/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    @IBOutlet weak var AcitivityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func onCreateUserButton(_ sender: Any) {
        
        
        self.AcitivityIndicator.startAnimating()
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        let confirmPass = confirmPassField.text
        
        if (confirmPass?.isEmpty)!{
            let OKAction = UIAlertAction(title: "OK", style: .default){(action) in}
            let alertController = UIAlertController(title: "Confirm is Required!", message: "Please Confirm your password.", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            self.AcitivityIndicator.stopAnimating()
        }else if (newUser.password != confirmPass!){
            let OKAction = UIAlertAction(title: "OK", style: .default){(action) in}
            let alertController = UIAlertController(title: "Don't Match", message: "Password don't match - Re-Enter your password.", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            self.AcitivityIndicator.stopAnimating()
        }else{
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            
            if (newUser.username?.isEmpty)!{
                let OKAction = UIAlertAction(title: "OK", style: .default){(action) in}
                let alertController = UIAlertController(title: "Username is Required!", message: "Please Choose your Username.", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.AcitivityIndicator.stopAnimating()
            }
            else if (newUser.password?.isEmpty)!{
                let OKAction = UIAlertAction(title: "OK", style: .default){(action) in}
                let alertController = UIAlertController(title: "Password is Required!", message: "Please Enter a New Password.", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.AcitivityIndicator.stopAnimating()
            }
            
            if let error = error{
                let errorAlertController = UIAlertController(title: "Sign up Failed!!!", message: "Account already exists for this username.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
                print(error.localizedDescription)
                self.AcitivityIndicator.stopAnimating()
            }else {
                PFUser.logOut()
                
                let OKAction = UIAlertAction(title: "OK", style: .default){(action) in
                    
                    print("Restered Success")
                    self.performSegue(withIdentifier: "logSegue", sender: nil)
                }
                let alertController = UIAlertController(title: "Registered Success!", message: "Now Enter your Username and password to Login.", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.AcitivityIndicator.stopAnimating()
                // manually segue to logged in view

            }
        }
    }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
