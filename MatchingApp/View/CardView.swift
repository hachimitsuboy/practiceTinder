//
//  CardView.swift
//  MatchingApp
//
//  Created by Nagae on 2021/07/25.
//

import UIKit

class CardView: UIView {
    
    let cardImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.backgroundColor = .systemTeal
        iv.layer.cornerRadius = 12
        iv.contentMode = .scaleToFill
        
        return iv
    }()
    
    let nameLabel:UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 36, weight: .heavy)
        nameLabel.textColor = .white
        nameLabel.text = "レオリオ, 16"
        
        
        return nameLabel
    }()
    
    let residenceLabel:UILabel = {
        
        let residenceLabel = UILabel()
        residenceLabel.font = .systemFont(ofSize: 20, weight: .regular)
        residenceLabel.textColor = .white
        residenceLabel.text = "日本、京都"
        
        
        return residenceLabel
    }()
    
    let hobbyLabel: UILabel = {
        
        let hobbyLabel = UILabel()
        hobbyLabel.font = .systemFont(ofSize: 25, weight: .regular)
        hobbyLabel.textColor = .white
        hobbyLabel.text = "サイクリング"
        
        
        return hobbyLabel
    }()
    
    let introductionLabel: UILabel = {
        
        let introductionLabel = UILabel()
        introductionLabel.font = .systemFont(ofSize: 25, weight: .regular)
        introductionLabel.textColor = .white
        introductionLabel.text = "旅行大好き"
        
        
        return introductionLabel
    }()
    
    
    
    let infoButton:UIButton = {
        
        let infoButton = UIButton(type: .system)
        infoButton.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        infoButton.tintColor = .white
        infoButton.imageView?.contentMode = .scaleAspectFit
        
        return infoButton
        
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        
        setupLayout()
        
        //UIPanGestureRecongnizerとは！？
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func panCardView(gesture: UIPanGestureRecognizer){
        
        //わからん
        let translation = gesture.translation(in: self)
        //わからん
        if gesture.state == .changed{
            //わからん
            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            
        } else if gesture.state == .ended { //ジェスチャーが終わったら？
            //0.2秒かけてアニメーションを行う
            UIView.animate(withDuration: 0.32) {
                //場所を元に戻す？
                self.transform = .identity
                //わからん
                self.layoutIfNeeded()
            }
        }
        
    }
    
    private func setupLayout(){
        
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalStackView.axis = .vertical
        
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView, infoButton])
        
        baseStackView.axis = .horizontal
        
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        
        //引数には、対応するView（親のView？っていうのかな？)の値を入れる
        cardImageView.anchor(top:topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        
        infoButton.anchor(width:40)
        
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 20, leftPadding: 22)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
