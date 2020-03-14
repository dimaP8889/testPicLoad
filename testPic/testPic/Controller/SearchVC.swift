//
//  ViewController.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 13.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class SearchVC: UITableViewController {
    
    // MARK: - Instance Properties
    lazy var resultSearchController : UISearchController = {
        
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        
        controller.searchBar.sizeToFit()
        
        return controller
    }()

    // MARK: - View Lyfecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        definesPresentationContext = true
        navigationItem.searchController = resultSearchController
        
        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        
        let test = Networking.pixbayAPI?.getImage("apple fruit")
        
    }
}

// MARK: - Extensions
extension SearchVC {
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell") else { return UITableViewCell() }
        
        cell.textLabel?.text = "Label"
        cell.imageView?.image = #imageLiteral(resourceName: "faceMasculine")
        cell.selectionStyle = .none
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

extension SearchVC {
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - Search Result
extension SearchVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
