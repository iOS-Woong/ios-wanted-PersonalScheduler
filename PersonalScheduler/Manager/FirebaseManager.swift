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
    
    func create(email: String, pw: String, completion: (() -> Void)? = nil) {
        Auth.auth().createUser(withEmail: email,
                               password: pw) { _, error in
            if let error = error {
                print(error, "------create Error-------")
                return
            }
            // fetch를 위한 구문
            if let completion = completion {
                completion()
            }
        }
    }
    
}
