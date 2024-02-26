//
//  MovieCell.swift
//  BoxOffice
//
//  Created by Lee minyeol on 2/22/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    var movie: DailyBoxOfficeInfo?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = MovieConfiguration().updated(for: state)
        newConfiguration.rank = movie?.rank
        newConfiguration.rankFluctuation = movie?.rankFluctuation
        newConfiguration.movieName = movie?.movieName
        newConfiguration.audienceCount = movie?.audienceCount
        newConfiguration.audienceAccumulation = movie?.audienceAccumulation
        
        contentConfiguration = newConfiguration
    }
}
