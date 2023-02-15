//
//  LoginViewModel.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewModel {
    
    private let kakaoLoginManager = KakaoLoginManager()
    private let fbLoginManager = FBLoginManager()
    private let firebaseManager = FirebaseManager()
    
    func kakaoLogin(completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        kakaoLoginManager.checkLoginEnabledAndLogin { [weak self] result in
            switch result {
            case .success(let user):
                guard let userEmail = user.kakaoAccount?.email,
                      let userId = user.id?.description else { return }
                self?.firebaseManager.create(email: userEmail,
                                             pw: userId,
                                             completion: completion)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fbLogin(_ from: UIViewController, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        fbLoginManager.login(from: from) { [weak self] result in
            switch result {
            case .success(let user):
                let userEmail = user.0,
                    userId = user.1
                self?.firebaseManager.create(email: userEmail, pw: userId, completion: completion)
            case .failure(let error):
                print(error)
            }
        }
    }
}
