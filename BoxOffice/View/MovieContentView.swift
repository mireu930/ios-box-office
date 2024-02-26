//
//  MovieContentView.swift
//  BoxOffice
//
//  Created by Lee minyeol on 2/26/24.
//

import UIKit

class MovieContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
