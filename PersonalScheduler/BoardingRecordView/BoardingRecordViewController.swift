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
        
        tableView.rowHeight = 170
        tableView.register(BoardingRecordTableViewCell.self, forCellReuseIdentifier: BoardingRecordTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: recordTableView) { tableView, indexPath, itemIdentifier in
            let cell = self.recordTableView.dequeueReusableCell(withIdentifier: BoardingRecordTableViewCell.reuseIdentifier,
                                                                for: indexPath) as? BoardingRecordTableViewCell ?? BoardingRecordTableViewCell()
            cell.configureCell(data: itemIdentifier)

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
        recordTableView.delegate = self
        setupViews()
        applySnapShot()
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationItem.title = "이용기록"
    }
    
    private func setupViews() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(recordTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            recordTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            recordTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            recordTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            recordTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func applySnapShot() {
        var snapShot = Snapshot()
        snapShot.appendSections([.main])
        snapShot.appendItems(BoardingHistory.sampleData)
        dataSource.apply(snapShot)
    }
    
}

extension BoardingRecordViewController: UITableViewDelegate {
    
}

/*
 guard let cartypeLabel = cell.carTypeLabel.text,
       let callTypeLabel = cell.callTypeLabel.text,
       let startLocationLabel = cell.startLocationLabel.text,
       let endLocationLabel = cell.endLocationLabel.text,
       let fareLabel = cell.fareLabel.text else { return }
 
 let sampleData = BoardingHistory.sampleData[indexPath.row]
 cell.carTypeImage.image = sampleData.carType.imageDescription
 cell.carTypeLabel += sampleData.carType.labelDescription
 cell.callTypeLabel += sampleData.callType.labelDescription
 cell.startLocationLabel += sampleData.startLocation
 cell.endLocationLabel += sampleData.endLocation
 cell.fareLabel += sampleData.fare.description
 */
