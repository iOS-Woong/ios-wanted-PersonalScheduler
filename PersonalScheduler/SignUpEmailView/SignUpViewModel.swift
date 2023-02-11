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
    
    private var inputEmail = String()
    private var inputPhoneNumber = String()
    private var inputPassword = String()
    
    func loadUserInputInformation(page: Page,
                                  textField: String) {
        switch page {
        case .email:
            inputEmail = textField
        case .phone:
            inputPhoneNumber = textField
        case .pw:
            inputPassword = textField
            makeUserInfoObject(email: inputEmail,
                               phone: inputPhoneNumber,
                               pw: inputPassword)
        }
    }
    
    private func makeUserInfoObject(email: String,
                                    phone: String,
                                    pw: String) -> InputUserInformation {
        let inputUserInformation = InputUserInformation(inputEmail: email,
                                                        inputPhoneNumber: phone,
                                                        inputPassword: pw)
        return inputUserInformation
    }
    
    private func firebaseCreate() {
        Auth.auth().createUser(withEmail: inputEmail, password: inputPassword) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            //FireStore Create
        }
    }
}

struct InputUserInformation {
    let inputEmail: String
    let inputPhoneNumber: String
    let inputPassword: String
}
