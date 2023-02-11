//
//  Page.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/10.
//

import UIKit

enum Page: Int {
    case email = 0
    case phone = 1
    case pw = 2
}

extension Page {
    var messageDescription: String {
        switch self {
        case .email:
            return  """
                    안녕하세요!
                    로그인에 사용할 이메일을 입력해주세요.
                    """
        case .phone:
            return "휴대폰 번호를 입력해주세요."
        case .pw:
            return "로그인에 사용할 비밀번호를 입력해주세요."
        }
    }
    
    var placeholderDescription: String {
        switch self {
        case .email:
            return "workplayhard1@naver.com"
        case .phone:
            return "010-6770-8357"
        case .pw:
            return "영문숫자 조합 10자리"
        }
    }
    
    var keyboardTypeDescription: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .phone:
            return .numberPad
        case .pw:
            return .default
        }
    }
    
    var buttonTitleDescription: String {
        switch self {
        case .email:
            return "다음"
        case .phone:
            return "다음"
        case .pw:
            return "완료"
        }
    }
    
}
