//
//  CardInfoLabel.swift
//  MatchingApp
//
//  Created by Nagae on 2021/07/25.
//

import UIKit

class CardInfoLabel: UILabel {
    //overrideがある時のエラー：Initializer does not override a designated initializer from its superclass
    
    //extensionとカスタムの違いって何？
    
    //NOPE・LIKEラベル用のinit
    init(frame: CGRect, labelText: String, labelColor: UIColor) {
        super .init(frame: frame)
        
        //あらかじめフォントをBoldにしてくれる？
        font = .boldSystemFont(ofSize: 46)
        text = labelText
        textColor = labelColor
        //borderWidthとは？
        layer.borderWidth = 3
        //UIColorとCGColorの違いとは？
        layer.borderColor = labelColor.cgColor
        layer.cornerRadius = 12
        //文字の配置
        textAlignment = .center
        //alpha値はどれだけ透かすか 0だと透明
        alpha = 0
    }
    
    //その他のラベル
    init(frame: CGRect, labelText: String, labelFont: UIFont) {
        super.init(frame: frame)
        
        font = labelFont
        textColor = .white
        text = labelText
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

