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
    func checkLoginEnabledAndLogin(completion: @escaping (Result<User, Error>) -> Void) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            logInWithUserApplication(completion: completion)
        } else {
            logInWithUserAccount(completion: completion)
        }
    }
    
    // 카톡(앱)으로 로그인
    private func logInWithUserApplication(completion: @escaping (Result<User, Error>) -> Void) {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")
                
                //do something
                _ = oauthToken
                setUserInfo(completion: completion)
            }
        }
    }
    
    // 카톡(계정)으로 로그인
    private func logInWithUserAccount(completion: @escaping (Result<User, Error>) -> Void) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                setUserInfo(completion: completion)
            }
        }
    }
        
    private func setUserInfo(completion: @escaping (Result<User, Error>) -> Void) {
        UserApi.shared.me { user, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let user = user else { return }
                completion(.success(user))
            }
        }
    }
}
