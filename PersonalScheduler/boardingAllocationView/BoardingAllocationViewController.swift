//
//  BoardingAllocationViewController.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/17.
//

import UIKit

class BoardingAllocationViewController: UIViewController {

    let boardingAllocationViewModel: BoardingAllocationViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(boardingAllocationViewModel: BoardingAllocationViewModel) {
        self.boardingAllocationViewModel = boardingAllocationViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
