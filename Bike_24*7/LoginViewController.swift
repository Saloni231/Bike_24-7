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
    
    @IBOutlet weak var usernameErrorMsg: UILabel!
    @IBOutlet weak var passwordErrorMsg: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Display Image
        appImage.layer.cornerRadius = appImage.frame.height/2
        
        //Welcome View
        welcomeView.layer.cornerRadius = 70
        
        //Function call for passcode
        //autherizeUserByPasscode()

        // Function call for face Id/ Touch Id
        authorizeUserByBiometerics()
        
    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        //Hiding Error Message
        usernameErrorMsg.isHidden = true
        passwordErrorMsg.isHidden = true
        
        //resetting text fields
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: Username Text Field Validation
    
    //Validating username when editing did end
    //MARK: Using Editing Did End
    @IBAction func usernameValidation(_ sender: Any) {
        
        if !(TextFieldValidation.emailValidation(usernameTextField.text!)) {
            
            usernameErrorMsg.text = "Email ID should be in valid Format. E.g. abc@domain.com"
            usernameErrorMsg.isHidden = false
        }
        else if (usernameTextField.text!.isEmpty) {
            
            usernameErrorMsg.text = "Please fill the field"
            usernameErrorMsg.isHidden = false
        }
        else {
            
            usernameErrorMsg.isHidden = true
        }
    }
    
    // Checking username text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func usernameCheck(_ sender: Any) {
        
        if (TextFieldValidation.emailValidation(usernameTextField.text!)){
            
            usernameErrorMsg.isHidden = true
        }
            
    }
    
    //MARK: Password Text Field Validation
    
    //Checking if password field is empty (Editing did end)
    //MARK: Using Editing Did End
    @IBAction func passwordCheck(_ sender: Any) {
        
        if (passwordTextField.text!.isEmpty) {
            
            passwordErrorMsg.isHidden = false
        }
    }
    
    //Hidding error message when user type some value for password (Editing Changed)
    //MARK: Using Editing Changed
    @IBAction func passwordTyped(_ sender: Any) {
        
        passwordErrorMsg.isHidden = true
    }
    
    
    //MARK: Credential Validation
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        // Checking if username text field is empty
        if (usernameTextField.text!.isEmpty) {
            
            usernameErrorMsg.text = "Please fill the field"
            usernameErrorMsg.isHidden = false
        }
        
        //Checking if username is valid
        else if !(TextFieldValidation.emailValidation(usernameTextField.text!)) {
            
            usernameErrorMsg.text = "Username should be in valid Format. E.g. abc@domain.com"
            usernameErrorMsg.isHidden = false
        }
        
        //Checking if password text field is empty
        if (passwordTextField.text!.isEmpty) {
            
            passwordErrorMsg.text = "Please fill the field"
            passwordErrorMsg.isHidden = false
        }
        
        //Firebase authentication
        if (usernameErrorMsg.isHidden && passwordErrorMsg.isHidden) {
            
            //MARK: Sign In using Firebase
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!, completion: {(result, error) -> Void in
                
                if error == nil {
                    
                    //MARK: Storing in Keychain
                    let _ = KeyChainOperations.saveKey(key: self.usernameTextField.text!, password: Data(self.passwordTextField.text!.utf8))
                    
                    //let dashboard = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardTabBarController")
                    //self.navigationController?.pushViewController(dashboard!, animated: true)
                }
                else {
                    
                    if let errorCode = error as NSError? {
                        
                        switch errorCode.code {
                            
                        case 17009:
                            self.alert("Password Does Not Match")
                        case 17011:
                            self.alert("User Does Not Exist.\n Please Sign Up.")
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
        let alertBox = UIAlertController(title: "Login Failed!", message: msg, preferredStyle: .alert)
        alertBox.addAction(UIAlertAction(title: "Okay", style: .destructive))
        self.present(alertBox, animated: true, completion: nil)
    }
    
    //MARK: Authentication Failure Alert Action
    func authFailureAlert(_ msg: String) {
        
        let alert = UIAlertController(title: "Autherization Failed!", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .destructive, handler: { (action: UIAlertAction) in exit(-1)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Authentication Success Alert Action
    func authSuccessAlert() {
        
        let sucessBox = UIAlertController(title: "Autherization Sucess!!", message: "Successfully authenticated user", preferredStyle: .alert)
        self.present(sucessBox, animated: true, completion: { Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
    }
    
    //MARK: Face ID / Touch ID Authentication
    func authorizeUserByBiometerics() {
        
        let authContextBio = LAContext()
        
        var authErrorBio: NSError?
        
        let authReasonBio = "Application Needs to authenticate user for Security Reasons."
        
        if authContextBio.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authErrorBio) {
            
            authContextBio.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReasonBio, reply: {
                success, error in
                
                DispatchQueue.main.async {
                    
                    if let evaluateError = error as NSError?{
                            
                        switch evaluateError.code {
                        case LAError.authenticationFailed.rawValue :
                            self.authFailureAlert("Authentication Failed as user provided invalid authentication")
                        case LAError.userCancel.rawValue :
                            self.authFailureAlert("Authentication Failed as user pressed cancel button")
                        case LAError.systemCancel.rawValue :
                            self.authFailureAlert("Authentication Failed as some other application came in foreground")
                        default :
                            self.authFailureAlert("Some other error occured")
                    
                        }
                        
                    }else {
                        self.authSuccessAlert()
                    }
                }
            })
        }
        else {
            
            switch authErrorBio!.code {
            case LAError.biometryLockout.rawValue :
                self.authFailureAlert("Biometeric Authentication is lock out.")
            case LAError.biometryNotEnrolled.rawValue :
                self.authFailureAlert("Biometeric is not enrolled by user.")
            case LAError.biometryNotAvailable.rawValue :
                self.authFailureAlert("Biometeric is not available on this device")
            default :
                self.authFailureAlert("Some other error occured")
        
            }
        }
    }
    
    //MARK: Passcode Autherization
    func autherizeUserByPasscode() {
        
        let authContext = LAContext()
        
        var authError : NSError?
        
        let authReason = "Application Needs to authenticate user for Security Reasons."
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            
            authContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: authReason, reply: {
                success, error in
                
                DispatchQueue.main.async {
                    
                    if let evaluteError = error as NSError? {
                        
                        switch evaluteError.code {
                            
                        case LAError.authenticationFailed.rawValue :
                            self.authFailureAlert("Authentication Failed as user failed to provide valid credentials.")
                        case LAError.userCancel.rawValue :
                            self.authFailureAlert("Authentication Failed as user pressed cancel button.")
                        case LAError.systemCancel.rawValue :
                            self.authFailureAlert("Authentication Failed as some other application came in foreground")
                        default:
                            self.authFailureAlert("Some other error occured")
                        }
                    }
                    else {
                        self.authSuccessAlert()
                    }
                }
            })
        }
        
    }
}

