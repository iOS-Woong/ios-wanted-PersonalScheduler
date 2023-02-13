//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import Foundation
import UIKit

class LoginViewModel {
    
    private let kakaoLoginManager = KakaoLoginManager()
    private let fbLoginManager = FBLoginManager()
    
    func kakaoLogin() {
        kakaoLoginManager.checkLoginEnabledAndLogin()
    }
    
    func fbLogin(_ from: UIViewController) {
        fbLoginManager.login(from: from)
    }
    
}
