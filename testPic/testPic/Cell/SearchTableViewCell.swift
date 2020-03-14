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
    
    lazy var mainView = MainCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addMainViewConstraits()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleData(data : SearchModel) {
        
        mainView.handleData(data: data)
    }
    
    private func addMainViewConstraits() {
        
        let marginGuide = contentView.layoutMarginsGuide
        
        addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchorConstrait = mainView.topAnchor.constraint(equalTo: marginGuide.topAnchor)
        let bottomAnchorConstrait = mainView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 10)
        let leftAnchorConstrait = mainView.leftAnchor.constraint(equalTo: marginGuide.leftAnchor)
        let rightAnchorConstrait = mainView.rightAnchor.constraint(equalTo: marginGuide.rightAnchor)
        
        NSLayoutConstraint.activate([topAnchorConstrait, bottomAnchorConstrait, leftAnchorConstrait, rightAnchorConstrait])
    }
}
