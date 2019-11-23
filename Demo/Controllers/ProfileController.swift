//
//  ProfileController.swift
//  Demo
//
//  Created by Rushabh Shah on 11/23/19.
//  Copyright © 2019 Rushabh Shah. All rights reserved.
//

import UIKit

class ProfileController: UITableViewController {

    //MARK: Outlets
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    //MARK: - Main View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    //MARK: - Handle Button Actions
    @IBAction func didTapLogoutBarButton(_ sender: UIBarButtonItem) {
        CoreDataManager.shared.deleteAllData(forEntity: .user)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Other Methods
    private func setupData() {
        CoreDataManager.shared.getUsers { (users) in
            if let firstUser = users.first {
                self.fullNameLabel.text = firstUser.fullname
                self.userNameLabel.text = firstUser.username
                self.emailLabel.text = firstUser.email
                self.dobLabel.text = (firstUser.dob ?? Date()).getString(inFormat: "dd-MMM-yyyy")
                self.mobileNumberLabel.text = firstUser.mobile_number
                if let imageData = firstUser.user_image, let image = UIImage(data: imageData) {
                    self.userProfileImageView.image = image
                }
            }
        }
    }

}
