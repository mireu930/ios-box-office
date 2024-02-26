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
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var networkManager = NetworkManager()
    var movieList: [DailyBoxOfficeInfo] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        fetchData()
        configureUI()
    }
    
    func fetchData() {
        let date = Date().yesterday(format: "yyyyMMdd")
        let modifyUrl = networkManager.modifyUrlComponent(path: MovieOffice.DailyUrl)
        guard let url = modifyUrl?.appending("targetDt", value: date)?.absoluteString else { return }
        
        networkManager.fetchData(url: url) { response in
            switch response {
            case .success(let data):
                self.movieList = Decoder().decodeDailyBoxOfficeList(data)
                DispatchQueue.main.async {
                    self.applySnapshot()
                    self.collectionView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print("\(error.localizedDescription) 에러 1")
            }
        }
    }
    
    @objc func handleRefresh() {
        fetchData()
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
    
    func applySnapshot() {
       var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeInfo>()
       snapshot.appendSections([.main])
       snapshot.appendItems(movieList, toSection: .main)
       
       dataSource?.apply(snapshot, animatingDifferences: false)
   }
    
    func configureUI() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(
            self,
            action: #selector(handleRefresh),
            for: .valueChanged
        )
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        self.title = Date().yesterday(format: "yyyy-MM-dd")
        
        autoLayout()
    }
    
    private func autoLayout() {
        
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
