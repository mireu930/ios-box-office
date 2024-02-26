//
//  MovieContentView.swift
//  BoxOffice
//
//  Created by Lee minyeol on 2/26/24.
//

import UIKit

class MovieContentView: UIView, UIContentView {
    private var rankLabel = UILabel()
    private var rankFluctuationLabel = UILabel()
    private var rankStackView = UIStackView()
    private var movieNameLabel = UILabel()
    private var audienceCountLabel = UILabel()
    private var movieStackView = UIStackView()
    
    var configuration: UIContentConfiguration {
        didSet {
            apply(configuration)
        }
    }
    

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        apply(configuration)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? MovieConfiguration else {
            return
        }
        
        guard let audienceCount = configuration.audienceCount,
              let audienceAccumulation = configuration.audienceAccumulation,
        let rankFluctuation = configuration.rankFluctuation
        else {
            return
        }
        
        rankLabel.text = configuration.rank
        movieNameLabel.text = configuration.movieName
        audienceCountLabel.text = "오늘 \(audienceCount) / 총 \(audienceAccumulation)"
        if configuration.rankOldAndNew == RankOldAndNew.new {
            rankFluctuationLabel.textColor = .systemRed
            rankFluctuationLabel.text = "신작"
        } else if rankFluctuation == "0" {
            rankFluctuationLabel.text = rankFluctuation
        } else if rankFluctuation.hasPrefix("-") {
            rankFluctuationLabel.text = "▼\(rankFluctuation.replacingOccurrences(of: "-", with: ""))"
            rankFluctuationLabel.textColor = .blue
        } else {
            rankFluctuationLabel.text = "▲\(rankFluctuation)"
            rankFluctuationLabel.textColor = .red
        }
    }
    
    func configureUI() {
        addSubview(rankStackView)
        addSubview(movieNameLabel)
        addSubview(audienceCountLabel)
        
        rankLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        rankLabel.adjustsFontForContentSizeCategory = true
        
        rankFluctuationLabel.font = UIFont.preferredFont(forTextStyle: .body)
        rankFluctuationLabel.adjustsFontForContentSizeCategory = true
        
        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        rankStackView.axis = .vertical
        rankStackView.alignment = .center
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankFluctuationLabel)
        
        movieNameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        movieNameLabel.adjustsFontForContentSizeCategory = true
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        audienceCountLabel.font = UIFont.preferredFont(forTextStyle: .body)
        audienceCountLabel.adjustsFontForContentSizeCategory = true
        audienceCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        autoLayout()
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            movieNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            movieNameLabel.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 10),
            movieNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            audienceCountLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            audienceCountLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            audienceCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            rankStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            rankStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            rankStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            rankStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ])
    }
    
}
