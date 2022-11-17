//
//  ViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/14/22.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import LocalAuthentication

class LoginViewController: UIViewController {

    //MARK: Outlet Connection
    @IBOutlet weak var welcomeView: UIView!
    
    @IBOutlet weak var appImage: UIImageView!

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Welcome View
        welcomeView.layer.cornerRadius = 70
        
        //Text Field Border
        usernameTextField.layer.borderWidth = 0.2
        usernameTextField.layer.cornerRadius = 9
        passwordTextField.layer.borderWidth = 0.2
        passwordTextField.layer.cornerRadius = 9
        
        //Imagviews for textfield logo
        let emailImageView = UIImageView()
        let passwordImageView = UIImageView()
        let emailIcon = UIImage(named: "email.png")
        let passwordIcon = UIImage(named: "password.png")
        emailImageView.image = emailIcon
        passwordImageView.image = passwordIcon
        passwordTextField.leftViewMode = .always
        usernameTextField.leftViewMode = .always
        
        usernameTextField.leftView = emailImageView
        passwordTextField.leftView = passwordImageView

        
    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        //resetting text fields
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: Username Text Field Validation
    
    //Validating username when editing did end
    //MARK: Using Editing Did End
    @IBAction func usernameValidation(_ sender: Any) {
        
        if (!(TextFieldValidation.emailValidation(usernameTextField.text!)) && !(usernameTextField.text!.isEmpty)) {
            
            alert("Email ID should be in valid Format. E.g. abc@domain.com")
        }
    }
    
    //MARK: Credential Validation
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        // Checking if username text field is empty
        if (usernameTextField.text!.isEmpty) {
            
            alert("Please Enter Email ID")
        }
        
        //Checking if username is valid
        else if !(TextFieldValidation.emailValidation(usernameTextField.text!)) {
            
            alert("Username should be in valid Format. E.g. abc@domain.com")
        }
        
        //Checking if password text field is empty
        else if (passwordTextField.text!.isEmpty) {
            
            alert("Please Enter Password")
        }
        
        //Firebase authentication
        else {
            
            //MARK: Sign In using Firebase
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!, completion: {(result, error) -> Void in
                
                if error == nil {
                    
                    let home = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController")
                    self.navigationController?.pushViewController(home!, animated: true)
                }
                else {
                    
                    if let errorCode = error as NSError? {
                        
                        switch errorCode.code {
                            
                        case 17009:
                            self.alert("Password Does Not Match")
                        case 17011:
                            self.alert("Incorrect Email ID Or Password. \n If Don't have an account.\n Please Sign Up.")
                        default:
                            print("Something else happened.")
                        }
                    }
                }
            })
        }
    }
    
    //MARK: Sign Up
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    //MARK: Back Segue
    // Coming Back to Login View
    @IBAction func backToLoginPressed(_ segue: UIStoryboardSegue) {

    }
}

extension LoginViewController {
    
    //MARK: Alert Action
    func alert(_ msg: String) {
        let alertBox = UIAlertController(title: "Login Error!", message: msg, preferredStyle: .alert)
        alertBox.addAction(UIAlertAction(title: "Okay", style: .destructive))
        self.parent?.present(alertBox, animated: true, completion: nil)
    }
}

