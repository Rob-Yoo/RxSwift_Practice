//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by Jinyoung Yoo on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimplePickerViewController: UIViewController {

    private let simplePickerView = UIPickerView()
    private let simpleLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(simplePickerView)
        self.view.addSubview(simpleLabel)
        
        simplePickerView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        setPickerView()
    }

    private func setPickerView() {
        let items = Observable.just(["영화", "애니메이션", "드라마", "기타"])
        
        items
            .bind(to: simplePickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        simplePickerView.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }

}

