//
//  SimpleValidationViewController.swift
//  RxSwiftPractice
//
//  Created by Jinyoung Yoo on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimumLength = 5

final class SimpleValidationViewController: UIViewController {

    private let usernameTextField = UITextField()
    private let usernameValidLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordValidLabel = UILabel()
    private let submitButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        usernameValidLabel.text = "5글자 이상이어야 함"
        usernameValidLabel.textColor = .red
        passwordValidLabel.text = "5글자 이상이어야 함"
        passwordValidLabel.textColor = .red
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= minimumLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minimumLength }
            .share(replay: 1)
        
        let allValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }.share(replay: 1)
        
        
        usernameValid.bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        passwordValid.bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        allValid.map{ !$0 }.bind(to: submitButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func configureView() {
        view.addSubview(usernameTextField)
        view.addSubview(usernameValidLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidLabel)
        view.addSubview(submitButton)
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalTo(view).inset(150)
            make.height.equalTo(50)
        }
        
        usernameValidLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(150)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameValidLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view).inset(150)
            make.height.equalTo(50)
        }
        
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(150)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(150)
            make.height.equalTo(50)
        }
        
        usernameTextField.backgroundColor = .lightGray
        passwordTextField.backgroundColor = .lightGray
        submitButton.backgroundColor = .green
    }
    
}
