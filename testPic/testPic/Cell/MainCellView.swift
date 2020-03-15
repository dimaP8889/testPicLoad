//
//  MainCellView.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 14.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation
import UIKit

class MainCellView : UIView {
    
    // MARK: - Instance Properties
    var imageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var textLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont(name: "TimesNewRoman", size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        
        clipsToBounds = true
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func handleData(data : SearchModel) {
        
        textLabel.text = data.name
        imageView.image = UIImage(data: data.picture)
    }
    
    // MARK: - Handle Constraits
    private func addConstraints() {
        
        addSubview(imageView)
        addSubview(textLabel)
        
        addImageViewConstraits()
        addTextLabelConstraits()
    }
    
    private func addImageViewConstraits() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchorConstraint = imageView.topAnchor.constraint(equalTo: topAnchor)
        let leftAnchorConstraint = imageView.leftAnchor.constraint(equalTo: leftAnchor)
        let bottomAnchorConstraint = imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let widthConstraint = imageView.widthAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 1.2)
        
        NSLayoutConstraint.activate([topAnchorConstraint, leftAnchorConstraint, bottomAnchorConstraint, widthConstraint])
    }
    
    private func addTextLabelConstraits() {
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchorConstraint = textLabel.topAnchor.constraint(equalTo: topAnchor)
        let bottomAnchorConstraint = textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        let leftAnchorConstraint = textLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 32)
        let rightAnchorConstraint = textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -32)
        
        NSLayoutConstraint.activate([topAnchorConstraint, leftAnchorConstraint, bottomAnchorConstraint, rightAnchorConstraint])
    }
    
}
