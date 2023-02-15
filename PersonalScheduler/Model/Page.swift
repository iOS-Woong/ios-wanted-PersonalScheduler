//
//  Page.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/10.
//

import UIKit

enum Page {
    case email
    case pw
}

extension Page {
    var messageDescription: String {
        switch self {
        case .email:
            return  """
                    안녕하세요!
                    로그인에 사용할 이메일을 입력해주세요.
                    """
        case .pw:
            return "로그인에 사용할 비밀번호를 입력해주세요."
        }
    }
    
    var loginMessageDescription: String {
        switch self {
        case .email:
            return "가입하신 이메일 정보를 입력해주세요."
        case .pw:
            return "비밀번호를 입력해주세요."
        }
    }
    
    var placeholderDescription: String {
        switch self {
        case .email:
            return "workplayhard1@naver.com"
        case .pw:
            return "영문숫자 조합 10자리"
        }
    }
    
    var keyboardTypeDescription: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .pw:
            return .default
        }
    }
    
    var buttonTitleDescription: String {
        switch self {
        case .email:
            return "다음"
        case .pw:
            return "완료"
        }
    }
    
    var loginButtonTitleDescription: String {
        switch self {
        case .email:
            return "다음"
        case .pw:
            return "로그인"
        }
    }
}
