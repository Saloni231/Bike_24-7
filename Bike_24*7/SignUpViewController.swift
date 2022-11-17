//
//  SignUpViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/14/22.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    
    //MARK: Outlet Connection
    
    @IBOutlet weak var signUpImage: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        //Display Image
        signUpImage.layer.cornerRadius = signUpImage.frame.height / 2
        signUpImage.layer.borderColor = UIColor.blue.cgColor
        signUpImage.layer.borderWidth = 1
        
        //Text Field Border
        nameTextField.layer.borderWidth = 0.2
        emailTextField.layer.borderWidth = 0.2
        mobileTextField.layer.borderWidth = 0.2
        passwordTextField.layer.borderWidth = 0.2
        confirmPasswordTextField.layer.borderWidth = 0.2
        
        nameTextField.layer.cornerRadius = 9
        emailTextField.layer.cornerRadius = 9
        mobileTextField.layer.cornerRadius = 9
        passwordTextField.layer.cornerRadius = 9
        confirmPasswordTextField.layer.cornerRadius = 9
        
        // MARK: - ImageViews for TextField Icons starts
        let usernameImageView = UIImageView()
        let emailImageView = UIImageView()
        let mobileImageView = UIImageView()
        let passwordImageView = UIImageView()
        let confirmPasswordImageView = UIImageView()
        
        // MARK: - ImageViews for TextField Icons starts
        
        // Setting Images to imageviews
        usernameImageView.image = UIImage(named: "user.png")
        emailImageView.image = UIImage(named: "email.png")
        mobileImageView.image = UIImage(named: "phone.png")
        passwordImageView.image = UIImage(named: "password.png")
        confirmPasswordImageView.image = UIImage(named: "ConfirmPassword.png")
        
        // Settign Properties ti textfields
        nameTextField.leftViewMode = .always
        emailTextField.leftViewMode = .always
        mobileTextField.leftViewMode = .always
        passwordTextField.leftViewMode = .always
        confirmPasswordTextField.leftViewMode = .always
        
        nameTextField.leftView = usernameImageView
        emailTextField.leftView = emailImageView
        mobileTextField.leftView = mobileImageView
        passwordTextField.leftView = passwordImageView
        confirmPasswordTextField.leftView = confirmPasswordImageView
    }
    
    //MARK: Name Text Field Validation
    
    //Validating name text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func nameValidation(_ sender: Any) {
        
        if (nameTextField.text!.isEmpty) {
            
            alert("Please Enter Name")
        }
        else if !(TextFieldValidation.nameValidation(nameTextField.text!)) {
            
            alert("Name should be valid (i.e. Atleast 4 characters")
            
        }
    }
    
    
    //MARK: Email Text Field Validation
    
    
    //Validating email text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func emailValidation(_ sender: Any) {
        
        if (emailTextField.text!.isEmpty) {
            
            alert("Please Enter Email ID")
        }
        else if !(TextFieldValidation.emailValidation(emailTextField.text!)) {
            
            alert("Email ID should be in valid Format. E.g. abc@domain.com")
        }
    }
    
    
    //MARK: Mobile Text Field Validation
    
    //Validating mobile text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func mobileValidation(_ sender: Any) {
        
        if (mobileTextField.text!.isEmpty) {
            
            alert("Please Enter Mobile")
        }
        else if !(TextFieldValidation.mobileValidation(mobileTextField.text!)) {
            
            alert("Mobile Number should be 10 digit number. E.g. 1234567890")
        }
    }
    
    
    //MARK: Password Text Field Validation
    
    //Validating password text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func passwordValidation(_ sender: Any) {
        
        if (passwordTextField.text!.isEmpty) {
            
            alert("Please Enter Password")
        }
        else if !(TextFieldValidation.passwordValidation(passwordTextField.text!)) {
            
            alert("Password must be Alpha Numeric.")
        }
    }
    
    
    //MARK: Confirm Password Text Field Validation
    
    //Validating confirm password text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func confirmPasswordValidation(_ sender: Any) {
        
        if (confirmPasswordTextField.text!.isEmpty) {
            
            alert("Please Enter Confirm Password")
        }
        else if !(TextFieldValidation.confirmPasswordValidation(passwordTextField.text!, confirmPasswordTextField.text!)) {
            
            alert("Should be same as password")
        }
    }
    
    
    //MARK: Credential Validation
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        // Checking Name Text Field
        if (nameTextField.text!.isEmpty) {
            
            alert("Please Enter Name")
        }
        
        //validating Name text field
        else if(!TextFieldValidation.nameValidation(nameTextField.text!)) {
            
            alert("Name should be valid (i.e. Atleast 4 characters")
        }
                
        // Checking Email ID Text Field
        else if (emailTextField.text!.isEmpty) {
            
            alert("Please Enter Email ID")
        }
        
        //validating Email text field
        else if(!TextFieldValidation.emailValidation(emailTextField.text!)) {
            
            alert("Email ID should be in valid Format. E.g. abc@domain.com")
        }
        
        // Checking Mobile Text Field
        else if (mobileTextField.text!.isEmpty) {
            
            alert("Please Enter Mobile No.")
        }
        
        //validating Mobile text field
        else if(!TextFieldValidation.mobileValidation(mobileTextField.text!)) {
            
            alert("Mobile Number should be 10 digit number. E.g. 1234567890")
        }
        
        // Checking Password Text Field
        else if (passwordTextField.text!.isEmpty) {
            
            alert("Please Enter Password")
        }
        
        //validating Name text field
        else if(!TextFieldValidation.passwordValidation(passwordTextField.text!)) {
            
            alert("Password must be Alpha Numeric.")
        }
                
        // Checking Confirm Password Text Field
        else if (confirmPasswordTextField.text!.isEmpty) {
            
            alert("Please Enter Confirm Password")
        }
        
        //validating Name text field
        else if(!(TextFieldValidation.confirmPasswordValidation(passwordTextField.text!, confirmPasswordTextField.text!))) {
            
            alert("Should be same as password")
        }
        
        // Storing Data If Valid
        else
        {
            
            //MARK: Creating user in firebase
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [self](result, error) -> Void in
                
                if error == nil {
                    
                    //MARK: Storing data in core data
                    DBOperations.dbOperationInstance().insertDataToUser(name: nameTextField.text!, email: emailTextField.text!.lowercased(), mobile: mobileTextField.text!, password: passwordTextField.text!)
                    
                    //MARK: Success Alert
                    let successAlert = UIAlertController(title: "Sign Up Success!!", message: "User Created Successfully.", preferredStyle: .alert)
                    let home = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController")
                    successAlert.view.tintColor = .systemGreen
                    successAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(action: UIAlertAction!) in self.navigationController?.pushViewController(home!, animated: true)}))
                    self.present(successAlert, animated: true, completion: nil)
                }
                else {
                    
                    if let errorCode = error as NSError? {
                        switch errorCode.code {
                        case 17007:
                            self.alert("Email Id Already In Use.")
                        default:
                            print("Some other error occured")
                        }
                    }
                }
            })
        }
    }
}

extension SignUpViewController {
    
    // MARK: Alert Action
    func alert(_ msg: String) {
        
        let alertBox = UIAlertController(title: "Sign Up Error!!", message: msg, preferredStyle: .alert)
        alertBox.addAction(UIAlertAction(title: "Okay", style: .destructive))
        self.parent?.present(alertBox, animated: true, completion: nil)
    }
}
