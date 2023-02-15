//
//  KakaoLoginManager.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/12.
//


import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct KakaoLoginManager {
    
    let firebaseManager = FirebaseManager()
    
    // 카카오톡 간편로그인의 실행 가능여부를 확인 -> 로그인
    func checkLoginEnabledAndLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            logInWithUserApplication()
        } else {
            logInWithUserAccount()
        }
    }
    
    // 카톡(앱)으로 로그인
    private func logInWithUserApplication() {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")
                
                //do something
                _ = oauthToken
                setUserInfo()
            }
        }
    }
    
    // 카톡(계정)으로 로그인
    private func logInWithUserAccount() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                setUserInfo()
            }
        }
    }
        
    private func setUserInfo() {
        UserApi.shared.me { user, error in
            if let error = error {
                print(error)
            } else {
                guard let email = user?.kakaoAccount?.email else { return }
                let userId = "\(String(describing: user?.id))"
                // Firebase 생성구문
//                firebaseManager.create(email: email, pw: userId)
            }
        }
    }
}
