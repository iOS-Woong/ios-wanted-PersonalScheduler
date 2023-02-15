//
//  BoardingRecordViewController.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/15.
//

import UIKit

class BoardingRecordViewController: UIViewController {

    let boardingRecordViewModel: BoardingRecordViewModel
    
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
