//
//  MovieCell.swift
//  BoxOffice
//
//  Created by Lee minyeol on 2/22/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    var movie: DailyBoxOfficeInfo? {
        didSet {
            guard let movie = movie else { return }
            rankLabel.text = movie.rank
            rankFluctuationLabel.text = movie.audienceFluctuation
            movieNameLabel.text = movie.movieName
            audienceCountLabel.text = "오늘 \(movie.audienceCount)명 / 총 \(movie.audienceAccumulation)명"
        }
    }
    
    private var rankLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 22)

            return label
        }()

        private var rankFluctuationLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)

            return label
        }()

        private lazy var rankStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.spacing = 5

            stackView.addSubview(rankLabel)
            stackView.addSubview(rankFluctuationLabel)
            return stackView
        }()

        private var movieNameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)

            return label
        }()

        private var audienceCountLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18)

            return label
        }()

        private lazy var movieStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.distribution = .equalSpacing
            stackView.spacing = 3

            stackView.addSubview(movieNameLabel)
            stackView.addSubview(audienceCountLabel)
            return stackView
        }()
    
    override func awakeFromNib() {
           super.awakeFromNib()

           addSubview(rankStackView)
           addSubview(movieStackView)

           autoLayout()
       }
    
    func autoLayout() {
            NSLayoutConstraint.activate([
                rankStackView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 30),
                rankStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                rankStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                movieStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 20),
                movieStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20)
            ])
        }
}
