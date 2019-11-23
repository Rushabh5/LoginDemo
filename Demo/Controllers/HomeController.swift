//
//  HomeController.swift
//  Demo
//
//  Created by Rushabh Shah on 10/7/19.
//  Copyright © 2019 Rushabh Shah. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {

    //MARK: Outlets
    @IBOutlet weak var hexLabel: UILabel!
    
    //MARK: - Main View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        var convertedString = ""
        for singleHex in Constants.hexStrings {
            let newConvertedString = Constants.hexToStr(text: singleHex)
            convertedString = newConvertedString
        }
        convertedString = String(convertedString.dropFirst(4))
        hexLabel.text = convertedString
    }
    
    //MARK: - Handle Button Actions
    @IBAction func didTapLogoutBarButton(_ sender: UIBarButtonItem) {
        CoreDataManager.shared.deleteAllData(forEntity: .user)
        self.dismiss(animated: true, completion: nil)
    }

}
