//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import Foundation
import KakaoSDKUser

class LoginViewModel {
    
    func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            kakaoLoginWithKakaoTalkApp()
        } else {
            kakaoLoginWithKakaoAccount()
        }
    }
    
    private func kakaoLoginWithKakaoTalkApp() {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")
                
                //do something
                _ = oauthToken
            }
        }
    }
    
    private func kakaoLoginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
            }
        }
    }
}
