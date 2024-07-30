//
//  SimpleSwitchViewController.swift
//  RxSwiftPractice
//
//  Created by Jinyoung Yoo on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpleSwitchViewController: UIViewController {

    private let simpleSwitch = UISwitch()
    private let simpleLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(simpleSwitch)
        self.view.addSubview(simpleLabel)
        
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        simpleSwitch.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
        
        setSwitch()
    }

    private func setSwitch() {
        Observable.of(false, false, true, false, true, false)
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }

}

