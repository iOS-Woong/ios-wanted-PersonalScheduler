//
//  SceneDelegate.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import KakaoSDKAuth
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let loginViewModel = LoginViewModel()
        let loginViewController = LoginViewController(loginViewModel: loginViewModel)
// 테이블뷰 테스트용
//        let boardingViewModel = BoardingRecordViewModel()
//        let boardingRecordViewController = BoardingRecordViewController(boardingRecordViewModel: boardingViewModel)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.handleOpenUrl(url: url)
        }
        //FB
        ApplicationDelegate.shared.application(UIApplication.shared,
                                               open: url,
                                               sourceApplication: nil,
                                               annotation: [UIApplication.OpenURLOptionsKey.annotation])
    }
}
