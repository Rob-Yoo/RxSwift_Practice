//
//  SimpleTableViewController.swift
//  RxSwiftPractice
//
//  Created by Jinyoung Yoo on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpleTableViewController: UIViewController {
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        let items = Observable.just((0..<20).map { String($0) })
        
        items.bind(to: tableView.rx.items) { tableView, row, element in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            
            cell.textLabel?.text = String(row) + " " + element
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
    }
    
    func configureView() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}
