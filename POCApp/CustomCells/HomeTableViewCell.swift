//
//  HomeTableViewCell.swift
//  POCApp
//
//  Created by Ritesh on 07/11/20.
//  Copyright © 2020 Ritesh. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let wikiImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Constraints for labels in cell
    func setupConstraints() {
        wikiImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(wikiImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        wikiImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        wikiImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        wikiImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        wikiImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: wikiImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
    }
    
}
