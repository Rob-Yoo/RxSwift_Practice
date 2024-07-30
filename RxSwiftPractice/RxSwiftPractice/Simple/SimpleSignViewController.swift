//
//  SimpleSignViewController.swift
//  RxSwiftPractice
//
//  Created by Jinyoung Yoo on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpleSignViewController: UIViewController {

    private let simpleLabel = UILabel()
    private let signName = UITextField()
    private let signEmail = UITextField()
    private let signButton = UIButton()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(simpleLabel)
        self.view.addSubview(signName)
        self.view.addSubview(signEmail)
        self.view.addSubview(signButton)
        
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(150)
            make.horizontalEdges.equalTo(100)
        }
        
        signName.snp.makeConstraints { make in
            make.top.equalTo(simpleLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(view).inset(100)
            make.height.equalTo(50)
        }
        signName.backgroundColor = .lightGray
        
        
        signEmail.snp.makeConstraints { make in
            make.top.equalTo(signName.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(view).inset(100)
            make.height.equalTo(50)
        }
        signEmail.backgroundColor = .lightGray
        
        signButton.snp.makeConstraints { make in
            make.top.equalTo(signEmail.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(view).inset(100)
            make.height.equalTo(50)
        }
        signButton.backgroundColor = .blue
        
        setSign()
    }

    private func setSign() {
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { (value1, value2) in
            return "이름은 \(value1)이고 이메일은 \(value2) 입니다."
        }
        .bind(to: simpleLabel.rx.text)
        .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .bind { _ in
                print("hi")
            }
            .disposed(by: disposeBag)
    }

}
