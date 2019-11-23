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
    
    //MARK: - Main View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        var bounds = tableView.bounds
        bounds.size.height = bounds.size.height - 44
        tableView.tableHeaderView?.frame = bounds
    }
    
    //MARK: - Handle Button Actions
    @IBAction func didTapLogoutBarButton(_ sender: UIBarButtonItem) {
        CoreDataManager.shared.deleteAllData(forEntity: .user)
        self.dismiss(animated: true, completion: nil)
    }

}
