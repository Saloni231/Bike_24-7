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
import UIColorHexSwift

class SignUpViewController: UIViewController {
    
    
    //MARK: Outlet Connection
    
    @IBOutlet weak var signUpImage: UIImageView!

    @IBOutlet weak var nameErrorMsg: UILabel!
    @IBOutlet weak var emailErrorMsg: UILabel!
    @IBOutlet weak var mobileErrorMsg: UILabel!
    @IBOutlet weak var passwordErrorMsg: UILabel!
    @IBOutlet weak var confirmPasswordErrorMsg: UILabel!
    
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
        signUpImage.layer.borderColor = UIColor("#004445").cgColor
        signUpImage.layer.borderWidth = 1
        
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
        usernameImageView.image = UIImage(named: "username.png")
        emailImageView.image = UIImage(named: "email.png")
        mobileImageView.image = UIImage(named: "phone.png")
        passwordImageView.image = UIImage(named: "password.png")
        confirmPasswordImageView.image = UIImage(named: "confirmPass.png")
        
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
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        //Hiding Error Messages
        nameErrorMsg.isHidden = true
        emailErrorMsg.isHidden = true
        mobileErrorMsg.isHidden = true
        passwordErrorMsg.isHidden = true
        confirmPasswordErrorMsg.isHidden = true
    }
    
    //MARK: Name Text Field Validation
    
    //Validating name text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func nameValidation(_ sender: Any) {
        
        if (nameTextField.text!.isEmpty) {
            
            nameErrorMsg.text = "Please fill the field"
            nameErrorMsg.isHidden = false
        }
        else if !(TextFieldValidation.nameValidation(nameTextField.text!)) {
            
            nameErrorMsg.text = "Name should be valid (i.e. Atleast 4 characters)"
            nameErrorMsg.isHidden = false
        }
        else {
            
            nameErrorMsg.isHidden = true
        }
    }
    
    //Checking name text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func nameCheck(_ sender: Any) {
        
        if (TextFieldValidation.nameValidation(nameTextField.text!)) {
            
            nameErrorMsg.isHidden = true
        }
    }
    
    //MARK: Email Text Field Validation
    
    //Displaying rules for email text field (editing did begin)
    //MARK: Using Editing Did Begin
    @IBAction func emailRules(_ sender: Any) {
        
        if !(TextFieldValidation.emailValidation(emailTextField.text!)) {
            
            emailErrorMsg.text = "Email ID should be in valid Format. E.g. abc@domain.com"
            emailErrorMsg.textColor = .systemGreen
            emailErrorMsg.isHidden = false
        }
    }
    
    //Validating email text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func emailValidation(_ sender: Any) {
        
        if (emailTextField.text!.isEmpty) {
            
            emailErrorMsg.text = "Please fill the field"
            emailErrorMsg.textColor = .systemRed
            emailErrorMsg.isHidden = false
        }
        else if !(TextFieldValidation.emailValidation(emailTextField.text!)) {
            
            emailErrorMsg.text = "Email ID should be in valid Format. E.g. abc@domain.com"
            emailErrorMsg.textColor = .systemRed
            emailErrorMsg.isHidden = false
        }
        else {
            
            emailErrorMsg.isHidden = true
        }
    }
    
    //Checking email text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func emailCheck(_ sender: Any) {
        
        if (TextFieldValidation.emailValidation(emailTextField.text!)) {
            
            emailErrorMsg.isHidden = true
        }
        else {
            
            emailErrorMsg.text = "Email ID should be in valid Format. E.g. abc@domain.com"
            emailErrorMsg.textColor = .systemGreen
            emailErrorMsg.isHidden = false
        }
    }
    
    //MARK: Mobile Text Field Validation
    
    //Displaying rules for mobile text field (editing did begin)
    //MARK: Using Editing Did Begin
    @IBAction func mobileRules(_ sender: Any) {
        
        if !(TextFieldValidation.mobileValidation(mobileTextField.text!)) {
            
            mobileErrorMsg.text = "Mobile Number should be 10 digit number. E.g. 1234567890"
            mobileErrorMsg.textColor = .systemGreen
            mobileErrorMsg.isHidden = false
        }
    }
    
    //Validating mobile text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func mobileValidation(_ sender: Any) {
        
        if (mobileTextField.text!.isEmpty) {
            
            mobileErrorMsg.text = "Please fill the field"
            mobileErrorMsg.textColor = .systemRed
            mobileErrorMsg.isHidden = false
        }
        else if !(TextFieldValidation.mobileValidation(mobileTextField.text!)) {
            
            mobileErrorMsg.text = "Mobile Number should be 10 digit number. E.g. 1234567890"
            mobileErrorMsg.textColor = .systemRed
            mobileErrorMsg.isHidden = false
        }
        else {
            
            mobileErrorMsg.isHidden = true
        }
    }
    
    //Checking mobile text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func mobileCheck(_ sender: Any) {
        
        if (TextFieldValidation.mobileValidation(mobileTextField.text!)) {
            
            mobileErrorMsg.isHidden = true
        }
        else {
            
            mobileErrorMsg.text = "Mobile Number should be 10 digit number. E.g. 1234567890"
            mobileErrorMsg.textColor = .systemGreen
            mobileErrorMsg.isHidden = false
        }
    }
    
    //MARK: Password Text Field Validation
    
    //Displaying rules for password text field (editing did begin)
    //MARK: Using Editing Did Begin
    @IBAction func passwordRules(_ sender: Any) {
        
        if !(TextFieldValidation.passwordValidation(passwordTextField.text!)) {
            
            passwordErrorMsg.text = "Password must be:\n • At least 6 character long.\n • Contain at least one number and one special character.\n • And mixture of uppercase and lowercase letters."
            passwordErrorMsg.textColor = .systemGreen
            passwordErrorMsg.isHidden = false
        }
    }
    
    //Validating password text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func passwordValidation(_ sender: Any) {
        
        if (passwordTextField.text!.isEmpty) {
            
            passwordErrorMsg.text = "Please fill the field"
            passwordErrorMsg.textColor = .systemRed
            passwordErrorMsg.isHidden = false
        }
        else if !(TextFieldValidation.passwordValidation(passwordTextField.text!)) {
            
            passwordErrorMsg.text =  "Password must be:\n • At least 6 character long.\n • Contain at least one number and one special character.\n • And mixture of uppercase and lowercase letters."
            passwordErrorMsg.textColor = .systemRed
            passwordErrorMsg.isHidden = false
        }
        else {
            
            passwordErrorMsg.isHidden = true
        }
    }
    
    //Checking password text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func passwordCheck(_ sender: Any) {
        
        if (TextFieldValidation.passwordValidation(passwordTextField.text!)) {

            passwordErrorMsg.isHidden = true
        }
        else {
            
            passwordErrorMsg.text =  "Password must be:\n • At least 6 character long.\n • Contain at least one number and one special character.\n • And mixture of uppercase and lowercase letters."
            passwordErrorMsg.textColor = .systemGreen
            passwordErrorMsg.isHidden = false
        }
    }
    
    //MARK: Confirm Password Text Field Validation
    
    //Displaying rules for confirm pasword text field (editing did begin)
    //MARK: Using Editing Did Begin
    @IBAction func confirmPasswordRules(_ sender: Any) {
        
        if !(TextFieldValidation.confirmPasswordValidation(passwordTextField.text!, confirmPasswordTextField.text!)) {
            
            confirmPasswordErrorMsg.text = "Should be same as password"
            confirmPasswordErrorMsg.textColor = .systemGreen
            confirmPasswordErrorMsg.isHidden = false
        }
    }
    
    //Validating confirm password text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func confirmPasswordValidation(_ sender: Any) {
        
        if (confirmPasswordTextField.text!.isEmpty) {
            
            confirmPasswordErrorMsg.text = "Please fill the field"
            confirmPasswordErrorMsg.textColor = .systemRed
            confirmPasswordErrorMsg.isHidden = false
        }
        else if !(TextFieldValidation.confirmPasswordValidation(passwordTextField.text!, confirmPasswordTextField.text!)) {
            
            confirmPasswordErrorMsg.text = "Should be same as password"
            confirmPasswordErrorMsg.textColor = .systemRed
            confirmPasswordErrorMsg.isHidden = false
        }
        else {
            
            confirmPasswordErrorMsg.isHidden = true
        }
    }
    
    //Checking confirm password text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func confirmPasswordCheck(_ sender: Any) {
        
        if (TextFieldValidation.confirmPasswordValidation(passwordTextField.text!, confirmPasswordTextField.text!)) {
            
            confirmPasswordErrorMsg.isHidden = true
        }
        else {
            
            confirmPasswordErrorMsg.text = "Should be same as password"
            confirmPasswordErrorMsg.textColor = .systemGreen
            confirmPasswordErrorMsg.isHidden = false
        }
    }
    
    //MARK: Credential Validation
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        // Checking Name Text Field
        if (nameTextField.text!.isEmpty || !TextFieldValidation.nameValidation(nameTextField.text!)) {
            
            nameErrorMsg.isHidden = false
        }
                
        // Checking Email ID Text Field
        if (emailTextField.text!.isEmpty || !TextFieldValidation.emailValidation(emailTextField.text!)) {
            
            emailErrorMsg.textColor = .systemRed
            emailErrorMsg.isHidden = false
        }
        
        // Checking Mobile Text Field
        if (mobileTextField.text!.isEmpty || !TextFieldValidation.mobileValidation(mobileTextField.text!)) {
            
            mobileErrorMsg.textColor = .systemRed
            mobileErrorMsg.isHidden = false
        }
        
        // Checking Password Text Field
        if (passwordTextField.text!.isEmpty || !TextFieldValidation.passwordValidation(passwordTextField.text!)) {
            
            passwordErrorMsg.textColor = .systemRed
            passwordErrorMsg.isHidden = false
        }
                
        // Checking Confirm Password Text Field
        if (confirmPasswordTextField.text!.isEmpty || !(TextFieldValidation.confirmPasswordValidation(passwordTextField.text!, confirmPasswordTextField.text!))) {
            
            confirmPasswordErrorMsg.textColor = .systemRed
            confirmPasswordErrorMsg.isHidden = false
        }
        
        // Storing Data If Valid
        if (nameErrorMsg.isHidden && emailErrorMsg.isHidden && mobileErrorMsg.isHidden && passwordErrorMsg.isHidden && confirmPasswordErrorMsg.isHidden)
        {
            
            //MARK: Creating user in firebase
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [self](result, error) -> Void in
                
                if error == nil {
                    
                    //MARK: Storing data in core data
                    DBOperations.dbOperationInstance().insertDataToUser(name: nameTextField.text!, email: emailTextField.text!.lowercased(), mobile: mobileTextField.text!, password: passwordTextField.text!)
                    
                    //MARK: Success Alert
                    let successAlert = UIAlertController(title: "Sign Up Success!!", message: "User Created Successfully.", preferredStyle: .alert)
                    //let dashboard = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardTabBarController")
                    successAlert.view.tintColor = .systemGreen
                    //successAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(action: UIAlertAction!) in self.navigationController?.pushViewController(dashboard!, animated: true)}))
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
        
        let alertBox = UIAlertController(title: "Sign Up Failed!!", message: msg, preferredStyle: .alert)
        alertBox.addAction(UIAlertAction(title: "Okay", style: .destructive))
        self.present(alertBox, animated: true, completion: nil)
    }
}
