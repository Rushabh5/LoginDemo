//
//  LoginController.swift
//  Demo
//
//  Created by Rushabh Shah on 11/23/19.
//  Copyright © 2019 Rushabh Shah. All rights reserved.
//

import UIKit

class LoginController: UITableViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: CoreTextField!
    @IBOutlet weak var passwordTextField: CoreTextField!
    
    //MARK: - Properties
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CoreDataManager.shared.getUsers { (users) in
            if users.count > 0 {
                self.performSegue(withIdentifier: "PresentHomeNavVC", sender: nil)
            }
        }
    }

    //MARK: - Handle Button Touches
    @IBAction func didTapLoginButton(sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if validateFields(email: email, password: password) {
            APIClient.performLogin(withUserId: email, password: password) { (result) in
                switch result {
                case .success(let responseData):
                    if let dict = responseData.getResponseDictionary() {
                        CoreDataManager.shared.insertUser(fullName: "", userName: "", email: email, dob: Date(), mobileNumber: "", token: Constants.getString(from: dict["token"]), userImage: Constants.getString(from: dict["user_image"]), lastName: Constants.getString(from: dict["last_name"])) {
                            self.performSegue(withIdentifier: "PresentHomeNavVC", sender: nil)
                        }
                    }
                    
                    break
                case .failure(let error):
                    UIAlertController.showAlertWithOk(forTitle: "Cannot Login!", message: error.message ?? error.error.debugDescription, sender: self, okCompletion: nil)
                    break
                }
            }
        }
    }
    
    //MARK: - Other Methods
    private func validateFields(email: String, password: String) -> Bool {
        var message = ""
        if email.isEmpty {
            message = "Please enter your email"
        } else if !email.isEmail {
            message = "Please enter valid email"
        } else if password.isEmpty {
            message = "Please enter your password"
        }
        
        if !message.isEmpty {
            UIAlertController.showAlertWithOk(forTitle: "Cannot register!", message: message, sender: self, okCompletion: nil)
            return false
        }
        return true
    }
    
    
}
