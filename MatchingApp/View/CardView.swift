//
//  CardView.swift
//  MatchingApp
//
//  Created by Nagae on 2021/07/25.
//

//alpha値を調整することで、like,nopeを消えた様に見せる


import UIKit

class CardView: UIView {
    
    let cardImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.backgroundColor = .systemTeal
        iv.layer.cornerRadius = 12
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "testImage")
        //clipsToBoundsとは？
        iv.clipsToBounds = true
        
        return iv
    }()
    
    //名前用ラベル
    let nameLabel:UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 36, weight: .heavy)
        nameLabel.textColor = .white
        nameLabel.text = "レオリオ, 16"
        
        
        return nameLabel
    }()
    
    //住所用ラベル
    let residenceLabel:UILabel = {
        
        let residenceLabel = UILabel()
        residenceLabel.font = .systemFont(ofSize: 20, weight: .regular)
        residenceLabel.textColor = .white
        residenceLabel.text = "日本、京都"
        
        
        return residenceLabel
    }()
    
    //趣味用ラベル
    let hobbyLabel: UILabel = {
        
        let hobbyLabel = UILabel()
        hobbyLabel.font = .systemFont(ofSize: 25, weight: .regular)
        hobbyLabel.textColor = .white
        hobbyLabel.text = "サイクリング"
        
        
        return hobbyLabel
    }()
    
    //自己紹介用のラベル
    let introductionLabel: UILabel = {
        
        let introductionLabel = UILabel()
        introductionLabel.font = .systemFont(ofSize: 25, weight: .regular)
        introductionLabel.textColor = .white
        introductionLabel.text = "旅行大好き"
        
        
        return introductionLabel
    }()
    
    
    //情報を表示させるボタン
    let infoButton:UIButton = {
        
        let infoButton = UIButton(type: .system)
        infoButton.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        infoButton.tintColor = .white
        infoButton.imageView?.contentMode = .scaleAspectFit
        
        return infoButton
        
    }()
    
    let goodLabel:UILabel = {
        
        let goodLabel = UILabel()
        //あらかじめフォントをBoldにしてくれる？
        goodLabel.font = .boldSystemFont(ofSize: 46)
        goodLabel.text = "GOOD"
        goodLabel.textColor = .rgb(red: 137, green: 233, blue: 86)
        //borderWidthとは？
        goodLabel.layer.borderWidth = 3
        //UIColorとCGColorの違いとは？
        goodLabel.layer.borderColor = UIColor.rgb(red: 137, green: 233, blue: 86).cgColor
        goodLabel.layer.cornerRadius = 12
        //文字の配置
        goodLabel.textAlignment = .center
        //alpha値はどれだけ透かすか 0だと透明
        goodLabel.alpha = 0
        
        
        return goodLabel
    }()
    
    let nopeLabel:UILabel = {
        
        let nopeLabel = UILabel()
        nopeLabel.font = .boldSystemFont(ofSize: 46)
        nopeLabel.text = "NOPE"
        nopeLabel.textColor = .rgb(red: 222, green: 110, blue: 110)
        
        nopeLabel.layer.borderWidth = 3
        nopeLabel.layer.borderColor = UIColor.rgb(red: 222, green: 110, blue: 110).cgColor
        nopeLabel.layer.cornerRadius = 12
        nopeLabel.textAlignment = .center
        nopeLabel.alpha = 0
        
        
        return nopeLabel
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
           
            handlePanChage(translation: translation)
        } else if gesture.state == .ended { //ジェスチャーが終わったら？
           
            handlePanEnded()
        }
    }
    
    private func handlePanChage(translation: CGPoint){
        //回転をつけてるみたい（わからん）↓↓↓↓↓↓↓
        let degree:CGFloat = translation.x / 20
        let angle = degree * .pi / 100
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
        
        //alpha値をこのratioによって1/100値で設定する
        //カードのxの値によって管理するためにかけている
        //translationはcardImageが右に行くとプラスの値を取り、左に行くとマイナスの値を取る
        let ratio: CGFloat = 1 / 100
        let ratioValue = ratio * translation.x
        
        if translation.x > 0{
            
            self.goodLabel.alpha = ratioValue
        } else if translation.x < 0 {
            
            self.nopeLabel.alpha = -ratioValue
        }
        
        
        //↑↑↑↑↑↑↑↑↑↑↑↑↑↑
    }
    
    //元の位置に戻った時
    private func handlePanEnded(){
        
        //この引数たちは？わからん
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
            
            //場所を元に戻す？
            self.transform = .identity
            //わからん
            self.layoutIfNeeded()
            
            self.goodLabel.alpha = 0
            self.nopeLabel.alpha = 0
           
            
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
        addSubview(goodLabel)
        addSubview(nopeLabel)
        
        //引数には、対応するView（親のView？っていうのかな？)の値を入れる
        cardImageView.anchor(top:topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        
        infoButton.anchor(width:40)
        
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 20, leftPadding: 22)
        
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 60, topPadding: 25, leftPadding: 22)
        
        nopeLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 60, topPadding: 25, rightPadding: 22)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
