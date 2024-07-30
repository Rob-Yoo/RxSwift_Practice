//
//  SimpeTableViewController.swift
//  RxSwiftPractice
//
//  Created by Jinyoung Yoo on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpeTableViewController: UIViewController {

    private let simpleTableView = UITableView()
    private let simpleLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(simpleTableView)
        self.view.addSubview(simpleLabel)
        
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        simpleTableView.snp.makeConstraints { make in
            make.top.equalTo(simpleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        setTableView()
    }

    private func setTableView() {
        let items = Observable.just(["영화", "애니메이션", "드라마", "기타"])
        
        items.bind(to: simpleTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            
            cell.textLabel?.text = String(row) + ": " + element
            return cell
        }.disposed(by: disposeBag)
        
        simpleTableView.rx.modelSelected(String.self)
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }

}


