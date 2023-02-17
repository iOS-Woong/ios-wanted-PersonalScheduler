//
//  BoardingHistory.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/15.
//

import UIKit

struct BoardingHistory: Hashable {
    let id: UUID
    let carType: CarType
    let date: Date
    let driveTime: String
    let callType: CallType
    let startLocation: String
    let endLocation: String
    let fare: Int
}

enum CarType {
    case taxi
    case suv
    case van

    var imageDescription: UIImage? {
        switch self {
        case .taxi:
            return UIImage(named: "44801607")
        case .suv:
            return UIImage(named: "55658")
        case .van:
            return UIImage(named: "42320402")
        }
    }
    
    var labelDescription: String {
        switch self {
        case .taxi:
            return "택시"
        case .suv:
            return "승합차"
        case .van:
            return "밴"
        }
    }
    
}

enum CallType {
    case normal
    case blue
    case black
    case special
    
    var labelDescription: String {
        switch self {
        case .normal:
            return "일반"
        case .blue:
            return "블루"
        case .black:
            return "블랙"
        case .special:
            return "모범"
        }
    }
}


extension BoardingHistory {
    static let sampleData: [BoardingHistory] = [
        BoardingHistory(id: UUID(), carType: .taxi, date: Date(), driveTime: "12:10 - 12:16", callType: .normal, startLocation: "경북 구미시 광평동 산 28-9", endLocation: "형곡중학교", fare: 5800),
        BoardingHistory(id: UUID(), carType: .suv, date: Date(), driveTime: "13:40 - 15:30", callType: .black, startLocation: "동부시장", endLocation: "남부시장", fare: 5000),
        BoardingHistory(id: UUID(), carType: .van, date: Date(), driveTime: "13:50 - 18:40", callType: .blue, startLocation: "면목동 오칠륙다시구에 있습니다 이건 텍스트가어케되는지", endLocation: "봅시다 이건 넘어가면 안될텐데 어떨까요", fare: 5000),
        BoardingHistory(id: UUID(), carType: .taxi, date: Date(), driveTime: "22:40 - 23:50", callType: .special, startLocation: "상봉동에서 갑니다", endLocation: "어디루", fare: 5500),
        BoardingHistory(id: UUID(), carType: .taxi, date: Date(), driveTime: "00:00 - 10:10", callType: .normal, startLocation: "시작지점입니다", endLocation: "어디루갑니까여긴", fare: 5000),
        BoardingHistory(id: UUID(), carType: .taxi, date: Date(), driveTime: "12:10 - 12:16", callType: .normal, startLocation: "경북 구미시 광평동 산 28-9", endLocation: "형곡중학교", fare: 5800),
        BoardingHistory(id: UUID(), carType: .suv, date: Date(), driveTime: "13:40 - 15:30", callType: .black, startLocation: "동부시장", endLocation: "남부시장", fare: 5000),
        BoardingHistory(id: UUID(), carType: .van, date: Date(), driveTime: "13:50 - 18:40", callType: .blue, startLocation: "면목동 오칠륙다시구에 있습니다 이건 텍스트가어케되는지", endLocation: "봅시다 이건 넘어가면 안될텐데 어떨까요", fare: 5000),
        BoardingHistory(id: UUID(), carType: .taxi, date: Date(), driveTime: "22:40 - 23:50", callType: .special, startLocation: "상봉동에서 갑니다", endLocation: "어디루", fare: 5500),
        BoardingHistory(id: UUID(), carType: .taxi, date: Date(), driveTime: "00:00 - 10:10", callType: .normal, startLocation: "시작지점입니다", endLocation: "어디루갑니까여긴", fare: 5000),
        BoardingHistory(id: UUID(), carType: .taxi, date: Date(), driveTime: "12:10 - 12:16", callType: .normal, startLocation: "경북 구미시 광평동 산 28-9", endLocation: "형곡중학교", fare: 5800),
        BoardingHistory(id: UUID(), carType: .suv, date: Date(), driveTime: "13:40 - 15:30", callType: .black, startLocation: "동부시장", endLocation: "남부시장", fare: 5000),
        BoardingHistory(id: UUID(), carType: .van, date: Date(), driveTime: "13:50 - 18:40", callType: .blue, startLocation: "면목동 오칠륙다시구에 있습니다 이건 텍스트가어케되는지", endLocation: "봅시다 이건 넘어가면 안될텐데 어떨까요", fare: 5000),
        BoardingHistory(id: UUID(), carType: .taxi, date: Date(), driveTime: "22:40 - 23:50", callType: .special, startLocation: "상봉동에서 갑니다", endLocation: "어디루", fare: 5500),
        BoardingHistory(id: UUID(), carType: .taxi, date: Date(), driveTime: "00:00 - 10:10", callType: .normal, startLocation: "시작지점입니다", endLocation: "어디루갑니까여긴", fare: 5000)
    ]
}
