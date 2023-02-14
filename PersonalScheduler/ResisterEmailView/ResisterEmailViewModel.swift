//
//  SignUpViewModel.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel {
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
    
    func signInableEmail(email: String, completion: @escaping () -> Void) {
        firebaseManager.checkSignInableEmail(email: email, completion: completion)
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

// firebase 생성 구문 (Manager 함수로 처리하도록



//    func firebaseCreate(completion: @escaping () -> Void) {
//        Auth.auth().createUser(withEmail: inputUserInformation.email,
//                               password: inputUserInformation.password) { [weak self] result, error in
//            guard let self = self else { return }
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            // 현재는 firestore로 저장하는 것으로 되어있지만,
//            // 이 구문이 firestore에서 값을 fetch해오는 것으로 되어야한다.
//            let db = Firestore.firestore()
//            let userInfo = self.makeUserInfoData(phone: self.inputUserInformation.phone)
//
//            db.collection("users").addDocument(data: userInfo) { error in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//                completion()
//            }
//        }
//    }
