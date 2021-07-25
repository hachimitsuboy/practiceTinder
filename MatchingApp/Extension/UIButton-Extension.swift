//
//  UIButton-Extension.swift
//  MatchingApp
//
//  Created by Nagae on 2021/07/25.
//

import UIKit

extension UIButton{
    
    func createCardInfoButton() -> UIButton{
        
        self.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit
        //UIButton自身に14行から16行目の特性をつけて返す
        return self
    }
}
