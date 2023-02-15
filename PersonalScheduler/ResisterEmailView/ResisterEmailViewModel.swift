//
//  SignUpViewModel.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ResisterEmailViewModel {
    var inputInformation: Observable<InputUserInformation>?
    
    var inputUserInformation = InputUserInformation(email: "",
                                                    password: "")

    private let firebaseManager = FirebaseManager()
    
    func loadUserInputInformation(page: Page,
                                  textField: String) {
        switch page {
        case .email:
            inputUserInformation.email = textField
        case .pw:
            inputUserInformation.password = textField
            makeUserInfoObservableObject()
        }
    }
    
    func signUp(email: String, pw: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        firebaseManager.create(email: email, pw: pw, completion: completion)
    }
    
    func signInableEmail(email: String, completion: @escaping () -> Void) {
        firebaseManager.checkSignInableEmail(email: email, completion: completion)
    }
    
    func signIn(email: String, pw: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        firebaseManager.signIn(email: email, pw: pw, completion: completion)
    }
    
    private func makeUserInfoObservableObject() {
        let inputInfo = InputUserInformation(email: inputUserInformation.email,
                                             password: inputUserInformation.password)
        inputInformation = .init(inputInfo)
    }
    
    private func makeUserInfoData(phone: String) -> [String: Any] {
        let userInfo = [
            "phone":phone
        ]
        return userInfo
    }
}
