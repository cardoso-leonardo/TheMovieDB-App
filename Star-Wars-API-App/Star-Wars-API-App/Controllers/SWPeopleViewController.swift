//
//  ViewController.swift
//  Star-Wars-API-App
//
//  Created by Leonardo Cardoso on 20/01/23.
//

import UIKit

final class SWPeopleViewController: UIViewController {
    
    private let peopleListView = PeopleListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .systemBackground
        view.addSubview(peopleListView)
        
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            peopleListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            peopleListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            peopleListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            peopleListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
}

