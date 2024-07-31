//
//  AddingNumbersViewController.swift
//  RxSwiftPractice
//
//  Created by Jinyoung Yoo on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AddingNumbersViewController: UIViewController {
    
    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    let result = UILabel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureView()
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { num1, num2, num3 -> Int in
            return (Int(num1) ?? 0) + (Int(num2) ?? 0) + (Int(num3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }
    
    func configureView() {
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(result)
        
        number1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view).inset(150)
            make.height.equalTo(50)
        }
        
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view).inset(150)
            make.height.equalTo(50)
        }
        
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view).inset(150)
            make.height.equalTo(50)
        }
        
        result.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view).inset(200)
        }
        
        number1.backgroundColor = .blue
        number2.backgroundColor = .blue
        number3.backgroundColor = .blue
    }
}
