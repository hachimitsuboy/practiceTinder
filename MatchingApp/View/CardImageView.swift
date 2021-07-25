//
//  CardImageView.swift
//  MatchingApp
//
//  Created by Nagae on 2021/07/25.
//

import UIKit

class CardImageView: UIImageView {
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .systemTeal
        layer.cornerRadius = 12
        contentMode = .scaleAspectFill
        image = UIImage(named: "testImage")
        //clipsToBoundsとは？
        clipsToBounds = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
