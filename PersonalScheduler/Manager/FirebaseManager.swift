//
//  FirebaseManager.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/13.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct FirebaseManager {
    
    func create(email: String, pw: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        Auth.auth().createUser(withEmail: email,
                               password: pw) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let result = result else { return }
                completion(.success(result))
            }
        }
    }
    
    func checkSignInableEmail(email: String, completion: @escaping () -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { result, error in
            if let error = error {
                print(error)
                print("----emailCheckError------")
            }
            if let _ = result?.first {
                completion()
            }
        }
    }
    
    func signIn(email: String,
                pw: String,
                completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: pw) { result, error in
            if let error = error {
                print("로긴 실패")
                completion(.failure(error))
            } else {
                guard let result = result else { return }
                print("로긴 성공")
                completion(.success(result))
            }
        }
    }
}
