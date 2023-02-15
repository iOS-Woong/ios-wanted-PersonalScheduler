//
//  BoardingRecordViewController.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/15.
//

import UIKit

class BoardingRecordViewController: UIViewController {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, BoardingHistory>
    typealias DataSource = UITableViewDiffableDataSource<Section, BoardingHistory>
        
    private let boardingRecordViewModel: BoardingRecordViewModel
    
    private let recordTableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        return tableView
    }()
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: recordTableView) { tableView, indexPath, itemIdentifier in
            let cell = self.recordTableView.dequeueReusableCell(withIdentifier: BoardingRecordTableViewCell.reuseIdentifier,
                                                                for: indexPath) as? BoardingRecordTableViewCell ?? BoardingRecordTableViewCell()
            return cell
        }
        return dataSource
    }()
    
    init(boardingRecordViewModel: BoardingRecordViewModel) {
        self.boardingRecordViewModel = boardingRecordViewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
