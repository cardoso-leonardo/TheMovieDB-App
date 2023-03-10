//
//  TMDBPeopleListViewViewModel.swift
//  TheMovieDB-App
//
//  Created by Leonardo Cardoso on 20/01/23.
//

import Foundation
import UIKit

protocol TMDBPeopleListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectPerson (_ person: Person)
}

final class TMDBPeopleListViewViewModel: NSObject {
    
    public weak var delegate: TMDBPeopleListViewViewModelDelegate?
    
    private var people: [Person] = [] {
        didSet {
            for person in people {
                guard let profilePath = person.profile_path else { return }
                let viewModel = TMDBPeopleCollectionViewCellViewModel(nameText: person.name, profilePath: profilePath)
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var currentPage: Int = 0
    
    private var totalPages: Int = 0
    
    private var cellViewModels: [TMDBPeopleCollectionViewCellViewModel] = []
    
    public func fetchPeople() {
        TMDBService.shared.fetch(.listPeopleRequest, expecting: TMDBPopularPersonList.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.people = model.results
                self?.totalPages = model.total_pages
                self?.currentPage = model.page
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalPeople() {
        
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return currentPage <= totalPages
    }
}

//MARK: CollectionView
extension TMDBPeopleListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBPeopleCollectionViewCell.cellIdentifier, for: indexPath) as? TMDBPeopleCollectionViewCell else {
            fatalError("Unsupported Cell Type")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let person = people[indexPath.row]
        delegate?.didSelectPerson(person)
    }
}

//MARK: ScrollView
extension TMDBPeopleListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator else { return }
        
    }
}

