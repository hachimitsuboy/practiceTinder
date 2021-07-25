//
//  CardView.swift
//  MatchingApp
//
//  Created by Nagae on 2021/07/25.
//

//alpha値を調整することで、like,nopeを消えた様に見せる ep6
//画像上から下にかけてグラデーションをかけることで、画像が白い場合でも文字を読みやすくさせる　ep7
//GradientLayerの大きさを指定しなければならない


import UIKit

class CardView: UIView {
    
    //何これ？
    private let gradientLayer = CAGradientLayer()
    // MARK: UIView
    
    private let cardImageView = CardImageView(frame: .zero)
    private let nameLabel = CardInfoLabel(frame: .zero, labelText: "レオリオ, 16", labelFont: .systemFont(ofSize: 36, weight: .heavy))

    private let residenceLabel = CardInfoLabel(frame: .zero, labelText: "日本、京都", labelFont: .systemFont(ofSize: 20, weight: .regular))
    
    private let hobbyLabel = CardInfoLabel(frame: .zero, labelText: "サイクリング", labelFont: .systemFont(ofSize: 25, weight: .regular))
    
    private let introductionLabel = CardInfoLabel(frame: .zero, labelText: "旅行大好き", labelFont: .systemFont(ofSize: 25, weight: .regular))
    
    private let infoButton = UIButton(type: .system).createCardInfoButton()

    private let goodLabel = CardInfoLabel(frame: .zero, labelText: "LIKE", labelColor: .rgb(red: 137, green: 233, blue: 86))
    
    private let nopeLabel = CardInfoLabel(frame: .zero, labelText: "NOPE", labelColor: .rgb(red: 222, green: 110, blue: 110))
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        
        setupLayout()
        setupGradientLayer()
        //UIPanGestureRecongnizerとは！？
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        
        self.addGestureRecognizer(panGesture)
    }
    
    private func setupGradientLayer(){
        //グラデーションさせる二色を配列に入れる
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        //グラデーションさせる向き（方向）わからん？
        //→グラデーションを開始させる場所、終わらせる場所をgradientLayerの全体の割合で示してる？（今回はgradientLayerの上から全体の3割の位置からグラデーションが始まり、全体行きすぎた1.1倍のところで終わってる
        gradientLayer.locations = [0.3, 1,1]
        //Viewではなく、ImageViewに追加
        cardImageView.layer.addSublayer(gradientLayer)
    }
    
    //CardViewが作成されたタイミングで、GradientLayerの大きさを指定してあげる
    
    override func layoutSubviews() {
        //gradientLayerの大きさをCardViewの大きさと同じにする
        gradientLayer.frame = self.bounds
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
