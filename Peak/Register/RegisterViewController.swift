//
//  RegisterViewController.swift
//  Peak
//
//  Created by akshatha hegde on 5/15/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    //Register phone
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var requestCodeButton: UIButton!
    
    //Register Email
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var RegisterButton: UIButton!
    
    var phoneNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Mark : IBAction
    @IBAction func requestCodeButtonPressed(_ sender: Any) {
        
        if phoneNumberTextField.text != "" {
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberTextField.text!, uiDelegate: nil, completion: { ( VerificationID, error) in
                
                if error != nil
                {
                    print("Error in registering with phone number: \(error?.localizedDescription)")
                    return
                }
                self.phoneNumber = self.phoneNumberTextField.text!
                self.phoneNumberTextField.text = ""
                self.phoneNumberTextField.placeholder = self.phoneNumber!
                
                self.phoneNumberTextField.isEnabled = false
                self.codeTextField.isHidden = false
                self.requestCodeButton.setTitle("Register", for: .normal)
                
                UserDefaults.standard.set(VerificationID, forKey: kVERIFICATIONCODE)
                UserDefaults.standard.synchronize()
    
            })
        }
        
        if codeTextField.text != "" {
            FirebaseUser.registerUserWith(phoneNumber: phoneNumber!, verificationCode: codeTextField.text!, completion: {( error, _ shouldLogin) in
                
                if error != nil
                {
                    print("Error : \(error?.localizedDescription)")
                    return
                }
                
                if shouldLogin {
                    //go to main view
                    print("main view")
                }
                else
                {
                    //go to next view
                    print("next view")
                }
            })
        }
        
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if emailTextField.text != "" && nameTextField.text != "" && lastNameTextField.text
           != "", passwordTextField.text != "" {
            FirebaseUser.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!, firstName: nameTextField.text!, lastName: lastNameTextField.text!, completion: { (error) in
                
                if error != nil {
                    print("Error registering with email: \(error?.localizedDescription)")
                    return
                }
                
                self.goToMainView()
                
            })
            
        }
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
       goToMainView()
        
    }
    
    //MARK: HELPER FUNCTION
    
    func goToMainView(){
        
        let mainView = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC") as! UITabBarController
        self.present(mainView,animated: true,completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
