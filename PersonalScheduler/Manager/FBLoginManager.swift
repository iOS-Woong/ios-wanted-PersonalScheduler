//
//  FBLoginManager.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/13.
//

import Foundation
import FacebookLogin
import FBSDKCoreKit

struct FBLoginManager {

    private let firebaseManager = FirebaseManager()
    
    func login(from: UIViewController) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email"],
                           from: from) { result, error in
            if let error = error {
                print("Encountered Error: \(error)")
            } else if let result = result, result.isCancelled {
              print("Cancelled")
            } else {
                print("logged In")
                setUserInfo()
            }
        }
    }
    
    private func setUserInfo() {
        let request = GraphRequest(graphPath: "me", parameters: ["fields" : "email"])
        request.start { _, result, error in
            if let result = result as? [String: String], error == nil {
                guard let email: String = result["email"],
                      let userId: String = result["id"] else { return }
//                firebaseManager.create(email: email, pw: userId)
            }
        }
    }
}
