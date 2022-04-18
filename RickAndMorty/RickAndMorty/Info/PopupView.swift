//
//  PopupVIew.swift
//  RickAndMorty
//
//  Created by Tchariss on 18.04.2022.
//

import UIKit

class PopupView: UIView {

    // MARK: - Properties
    lazy var avatar: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true

        return image
    }()
    
    var name = UILabel(),
        race = UILabel(),
        gender = UILabel(),
        episode = UILabel(),
        location = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubviews()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setItem(item: Result, url: String?) {
        self.name.text = item.name
        self.race.text = item.species
        self.gender.text = item.gender
        self.episode.text = "Episodes : " + "\(item.episode.count)"
        if let location = item.location?.name {
            self.location.text = "Last location : " + location
        }
        if let url = url, let url = URL(string: url) {
            self.avatar.loadImage(from: url)
        }
    }
    
    func addSubviews() {
        addSubview(avatar)
        addSubview(name)
        addSubview(race)
        addSubview(gender)
        addSubview(episode)
        addSubview(location)
    }
    
    func setupSubviews() {
        name.translatesAutoresizingMaskIntoConstraints       = false
        race.translatesAutoresizingMaskIntoConstraints       = false
        gender.translatesAutoresizingMaskIntoConstraints     = false
        episode.translatesAutoresizingMaskIntoConstraints    = false
        location.translatesAutoresizingMaskIntoConstraints   = false
        
        NSLayoutConstraint.activate([
            avatar.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatar.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatar.widthAnchor.constraint(equalToConstant: 80),
            avatar.heightAnchor.constraint(equalToConstant: 80),
            
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16),
            name.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: -16),
            
            race.centerXAnchor.constraint(equalTo: centerXAnchor),
            race.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            
            gender.centerXAnchor.constraint(equalTo: centerXAnchor),
            gender.topAnchor.constraint(equalTo: race.bottomAnchor, constant: 8),
            
            episode.centerXAnchor.constraint(equalTo: centerXAnchor),
            episode.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 8),
            
            location.centerXAnchor.constraint(equalTo: centerXAnchor),
            location.topAnchor.constraint(equalTo: episode.bottomAnchor, constant: 8),
            location.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: -16)
        ])
    }
}
