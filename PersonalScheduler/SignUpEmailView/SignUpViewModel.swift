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
                                                    phone: "",
                                                    password: "")

    func loadUserInputInformation(page: Page,
                                  textField: String) {
        switch page {
        case .email:
            inputUserInformation.email = textField
        case .phone:
            inputUserInformation.phone = textField
        case .pw:
            inputUserInformation.password = textField
            makeUserInfoObservableObject()
        }
    }
    
    func firebaseCreate(completion: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: inputUserInformation.email,
                               password: inputUserInformation.password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let db = Firestore.firestore()
            let userInfo = self.makeUserInfoData(phone: self.inputUserInformation.phone)

            db.collection("users").addDocument(data: userInfo) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
                completion()
            }
        }
    }
    
    private func makeUserInfoObservableObject() {
        let inputInfo = InputUserInformation(email: inputUserInformation.email,
                                             phone: inputUserInformation.phone,
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

struct InputUserInformation {
    var email: String
    var phone: String
    var password: String
}
