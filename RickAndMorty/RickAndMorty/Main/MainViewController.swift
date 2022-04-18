//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Tchariss on 14.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let tableView = UITableView()
    let api = API()
    var model = [Result]()
    
    lazy var popUpView: PopupView = {
        let view = PopupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect.init(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismiss(_:)))
        view.addGestureRecognizer(recognizer)
        
        return view
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.dataSource = self
        tableView.delegate = self
        responseHandler()
        view.addSubview(tableView)
        setupView()
    }
    
    func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }
    
    func responseHandler() {
        api.createRequest { result in
            switch result {
            case .success(let characters):
                if let newModel = characters.results { self.model.append(contentsOf: newModel) }
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showPopUp() {
        
        visualEffectView.alpha = 0
        popUpView.alpha = 0
        
        view.addSubview(visualEffectView)
        view.addSubview(popUpView)
        
        NSLayoutConstraint.activate([
            popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpView.heightAnchor.constraint(equalToConstant: view.frame.width - 112),
            popUpView.widthAnchor.constraint(equalToConstant: view.frame.width - 96),
            
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 1
            self.popUpView.alpha = 1
        }

    }
    
    @objc func handleDismiss(_ recognizer: UIGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
            self.popUpView.alpha = 0
        }, completion: { _ in
            self.popUpView.removeFromSuperview()
            self.visualEffectView.removeFromSuperview()
        })
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = model[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        
        cell.name.text    = item.name
        cell.race.text    = item.species
        cell.gender.text  = item.gender
        if let imageURL = item.image, let url = URL(string: imageURL) {
            cell.avatar.loadImage(from: url)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = model[indexPath.row]
        
        popUpView.setItem(item: item, url: item.image)

        showPopUp()
    }
        
    // Позиция прокруктки (y)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        // Нужно загрузить след страницу
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            responseHandler()
        }
    }
    
}
