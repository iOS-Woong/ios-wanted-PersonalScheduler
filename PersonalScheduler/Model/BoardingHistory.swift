//
//  BoardingHistory.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/15.
//

import Foundation

struct BoardingHistory: Hashable {
    let carType: CarType
    let callType: CallType
    let startLocation: String
    let endLocation: String
    let fare: Int
}

enum CarType {
    case taxi
    case suv
    case van
}

enum CallType {
    case normal
    case blue
    case black
    case special
}
