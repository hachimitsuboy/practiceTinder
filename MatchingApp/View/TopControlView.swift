//
//  TopControlView.swift
//  MatchingApp
//
//  Created by Nagae on 2021/07/25.
//

import UIKit
import RxCocoa
import RxSwift

class TopControlView: UIView {
    
    
    private let disposeBag = DisposeBag()
    
    let matchingAppButton = createTopButton(imageName: "coin_selected", unselectedImage: "coin_unselected")
    let goodButton = createTopButton(imageName: "good_selected", unselectedImage: "good_unselected")
    let commentButton = createTopButton(imageName: "talk_selected", unselectedImage: "talk_unselected")
    let profileButton = createTopButton(imageName: "profile_selected", unselectedImage: "profile_unselected")
    
    
    
    static private func createTopButton(imageName:String, unselectedImage:String) -> UIButton{
        
        let button = UIButton(type: .custom)
        //ボタンが押された時
        button.setImage(UIImage(named: imageName), for: .selected)
        //ボタンが押されていない時（通常）
        button.setImage(UIImage(named: unselectedImage), for: .normal)
        //
        button.imageView?.contentMode = .scaleAspectFit
        return button
        
    }
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupLayout()
        setupBindings()
        
    }
    
    private func setupLayout(){
        
        backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [matchingAppButton, goodButton, commentButton, profileButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 45
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        [stackView.topAnchor.constraint(equalTo: topAnchor),
         stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
         stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
         stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)].forEach {$0.isActive = true}
        
        matchingAppButton.isSelected = true
        
    }
    
    
    private func setupBindings(){
        
        //matchingAppButtonが押された時
        //押された時の処理を.subscribeで登録しているのでは？？
        matchingAppButton.rx.tap
            .subscribe { _ in
                
                //タップされたらここがまず呼ばれるらしい
                //#function今いるメソッドの名前が呼ばれるらしい
                self.handleSelectedButton(selectedButton: self.matchingAppButton)
            }
            //もう決まり文句らしい。ゴミ箱
            .disposed(by: disposeBag)
        
        
        goodButton.rx.tap
            .subscribe { _ in
                
                //なぜhandleSelectedButtonメソッドにはselfがいるのか？
                //→クロージャの中だから
                self.handleSelectedButton(selectedButton: self.goodButton)
            }
            .disposed(by: disposeBag)
        
        commentButton.rx.tap
            .subscribe { _ in
                
                self.handleSelectedButton(selectedButton: self.commentButton)
            }
            .disposed(by: disposeBag)
        
        profileButton.rx.tap
            .subscribe { _ in
                
                self.handleSelectedButton(selectedButton: self.profileButton)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func handleSelectedButton(selectedButton: UIButton){
        
        let buttons = [matchingAppButton, goodButton, commentButton, profileButton]
        
        buttons.forEach { button in
            
            if button == selectedButton{
                //isSelectedがtrueの時27行目で書かれた箇所が呼ばれる
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
