//
//  ViewController.swift
//  MatchingApp
//
//  Created by Nagae on 2021/07/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let topControlView = TopControlView()
        let cardView = CardView()
        let bottomControlView = BottomControlView()
        
        let stackView = UIStackView(arrangedSubviews: [topControlView,cardView,bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //view1,view2,view3をどの軸（縦か横か)で配置するか
        stackView.axis = .vertical
    
        
        self.view.addSubview(stackView)
        
        //制約を配列としてまとめて、forEatchで全ての要素（制約）をactiveにする
        [
            //高さを100にする
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
    
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor)].forEach{$0.isActive = true}
        
        // Do any additional setup after loading the view.
    }
    
    
}

