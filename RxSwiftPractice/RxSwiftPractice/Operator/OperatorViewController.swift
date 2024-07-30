//
//  OperatorViewController.swift
//  RxSwiftPractice
//
//  Created by Jinyoung Yoo on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa

class OperatorViewController: UIViewController {
    let itemsA = [1, 2, 3, 4, 5, 6]
    let itemsB = [7, 8, 9, 10, 11]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just(itemsA)
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Complete")
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)
        
        print("---------")
        
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Complete")
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)
        
        print("---------")
        
        Observable.from(itemsA)
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Complete")
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)
        
        print("---------")
        
        Observable.repeatElement("Jinyoo")
            .take(10)
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Complete")
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)
    }
}
