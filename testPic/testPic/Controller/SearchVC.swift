//
//  ViewController.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 13.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchVC: UITableViewController {
    
    // MARK: - Instance Properties
    lazy var resultSearchController : UISearchController = {
        
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        
        controller.searchBar.sizeToFit()
        
        controller.searchBar.delegate = self
        
        return controller
    }()
    
    let caretaker = DataManager()
    
    var model : [SearchModel] {
        
        let data = caretaker.load().sorted { $0.creationDate > $1.creationDate }
        return filterWord.isEmpty ? data : data.filter { $0.name.lowercased().contains(filterWord.lowercased()) }
    }
    
    var filterWord : String {
        return resultSearchController.searchBar.text ?? ""
    }
    

    // MARK: - View Lyfecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        definesPresentationContext = true
        navigationItem.searchController = resultSearchController
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchCell")
        
        setNavBar()
    }
    
    // MARK: - View Handloigs
    func setNavBar() {
        
        self.title = "Picture Searcher"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: - Extensions
extension SearchVC {
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")
            as? SearchTableViewCell else { return UITableViewCell() }
        
        let data = model[indexPath.row]
        
        cell.handleData(data: data)
        return cell
    }
    
}

extension SearchVC {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            
            var newModel = model
            
            let deleted = newModel.remove(at: indexPath.row)
            
            caretaker.delete(deleted)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension SearchVC {
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
}

// MARK: - Search Result
extension SearchVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Search Result
extension SearchVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        SVProgressHUD.show()
        
        guard let imageName = searchBar.text else { return }
        guard !imageName.isEmpty else { return }
        
        DispatchQueue.global().async {
            
            guard let image = Networking.pixbayAPI?.getImage(imageName) else { return }
            guard let png = image.pngData() else { return }
            
            let data = SearchModel(name: imageName, picture: png, creation: Date())
            
            DispatchQueue.main.async {
                self.caretaker.save(self.model + [data])
                self.tableView.reloadData()
            }
        }
    }
}
