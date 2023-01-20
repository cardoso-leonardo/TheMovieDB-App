//
//  ViewController.swift
//  Star-Wars-API-App
//
//  Created by Leonardo Cardoso on 20/01/23.
//

import UIKit

class ViewController: UIViewController {
 
    private let table = UITableView()
    private var peopleViewModels = [PeopleViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupTableViewConstraints()
        table.delegate = self
        table.dataSource = self
        table.register(PeopleCell.self, forCellReuseIdentifier: "cell")
        
        Service.shared.fetchPeopleData { people in
            self.peopleViewModels = people.map({return PeopleViewModel(people: $0)})
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    private func setupSubviews() {
        view.addSubview(table)
    }
    
    private func setupTableViewConstraints() {
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! PeopleCell
        cell.peopleViewModel = peopleViewModels[indexPath.row]
        return cell
    }

}

