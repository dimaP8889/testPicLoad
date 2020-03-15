//
//  SearchTableViewCell.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 14.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation
import UIKit

class SearchTableViewCell : UITableViewCell {
    
    // MARK: - Instance Properties
    lazy var mainView = MainCellView()
    
    // MARK: - View Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addMainViewConstraits()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func handleData(data : SearchModel) {
        
        mainView.handleData(data: data)
    }
    
    // MARK: - Handle Constraits
    private func addMainViewConstraits() {
        
        contentView.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchorConstrait = mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        let bottomAnchorConstrait = mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        let leftAnchorConstrait = mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        let rightAnchorConstrait = mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        
        bottomAnchorConstrait.priority = UILayoutPriority(999.0)
        
        NSLayoutConstraint.activate([topAnchorConstrait, bottomAnchorConstrait, leftAnchorConstrait, rightAnchorConstrait])
    }
}
