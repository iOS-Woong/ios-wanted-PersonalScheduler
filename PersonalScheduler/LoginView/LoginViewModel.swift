//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import Foundation

class LoginViewModel {
    
    private let kakaoLoginManager = KakaoLoginManager()
    
    func kakaoLogin() {
        kakaoLoginManager.checkLoginEnabledAndLogin()
    }
    
}
