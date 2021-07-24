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
        
        let view1 = UIView()
        view1.backgroundColor = .green
        let view2 = UIView()
        view2.backgroundColor = .systemIndigo
        let view3 = BottomControlView()
        
        let stackView = UIStackView(arrangedSubviews: [view1,view2,view3])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //view1,view2,view3をどの軸（縦か横か)で配置するか
        stackView.axis = .vertical
    
        
        self.view.addSubview(stackView)
        
        //制約を配列としてまとめて、forEatchで全ての要素（制約）をactiveにする
        [
            //高さを100にする
            view1.heightAnchor.constraint(equalToConstant: 100),
            view3.heightAnchor.constraint(equalToConstant: 120),
    
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor)].forEach{$0.isActive = true}
        
        // Do any additional setup after loading the view.
    }
    
    
}

