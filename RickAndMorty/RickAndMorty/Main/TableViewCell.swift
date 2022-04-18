//
//  TableViewCell.swift
//  RickAndMorty
//
//  Created by Tchariss on 14.04.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupStackView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.selectionStyle = .none
        setupStackView()
        setupConstraints()
    }
    
    // MARK: - Properties
    
    // StackView horizontal
    lazy var stackViewHorizontal: UIStackView = {
        var stack = UIStackView()
        stack.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        stack.axis            = .horizontal
        stack.spacing         = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
   
    // StackView vertical
    lazy var stackViewVertical: UIStackView = {
        var stack = UIStackView()
        stack.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        stack.axis            = .vertical
        stack.distribution    = .fillEqually
        stack.spacing         = 8
        stack.layoutMargins   = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    var avatar: CustomImageView = {
        var image = CustomImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var name = UILabel(),
        race = UILabel(),
        gender = UILabel()
    
    // MARK: - Methods
    
    func setupStackView() {
        contentView.addSubview(stackViewHorizontal)
        
        stackViewHorizontal.addArrangedSubview(avatar)
        stackViewHorizontal.addArrangedSubview(stackViewVertical)
        
        stackViewVertical.addArrangedSubview(name)
        stackViewVertical.addArrangedSubview(race)
        stackViewVertical.addArrangedSubview(gender)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewHorizontal.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            avatar.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}

