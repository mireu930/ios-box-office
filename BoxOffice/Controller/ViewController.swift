//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    enum Section: Hashable {
        case main
    }
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    var movieList: [DailyBoxOfficeInfo] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLayout()
        view.addSubview(collectionView)
        title = Date().yesterday(format: "yyyy-MM-dd")
        view.backgroundColor = .systemBackground
        configureDataSource()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc func handleRefresh() {
        
    }
    
    private func configureDataSource() {
            let cellRegistration = UICollectionView.CellRegistration<MovieCell, DailyBoxOfficeInfo> { cell, indexPath, item in
                cell.movie = item
            }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeInfo>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DailyBoxOfficeInfo) -> UICollectionViewCell? in

                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                        for: indexPath,
                                                                        item: identifier)
            return cell
        }
    }
    
    private func autoLayout() {
        view.addSubview(collectionView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension Date {
    func yesterday(format: String) -> String {
        let yesterday = Date(timeIntervalSinceNow: -86400)
        DateFormatter().dateFormat = format
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        
        guard let dateString = dateformat.string(for: yesterday) else { return ""}
        
        return dateString
    }
}
