//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit
import FacebookLogin

class LoginViewController: UIViewController {
    
    private let loginViewModel: LoginViewModel
    
    let headLabel = {
        let label = UILabel()
        
        label.text = "새로운 이동 기준, 타다"
        label.textColor = .facebookColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    let subLabel = {
        let label = UILabel()
        
        label.text =
                    """
                    승차거부 없는 바로배차
                    서비스 만족도 4.95점
                    재탑승률 90%
                    """
        label.numberOfLines = 0
        label.textColor = .facebookColor
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let kakaoLoginButton = {
        let button = UIButton()
        
        button.setTitle("카카오로 시작하기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .kakaoColor
        
        return button
    }()
    
    let facebookLoginButton = {
        let button = UIButton()
        
        button.backgroundColor = .facebookColor
        button.setTitle("페이스북으로 시작하기", for: .normal)
        
        return button
    }()
    
    let emailLoginButton = {
        let button = UIButton()
        
        button.setTitle("이메일로 로그인", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        
        return button
    }()
    
    let emailFlagLabel = {
        let label = UILabel()
        
        label.text = "|"
        label.textColor = .gray
        
        return label
    }()
    
    let emailResisterButton = {
        let button = UIButton()
        
        button.setTitle("이메일로 가입하기", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        
        return button
    }()
    
    let labelStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let emailLoginButtonStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    let loginButtonStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupViews()
        setupButton()
    }
    
    private func setupButton() {
        let kakaoLoginAction = UIAction { [weak self] _ in
            //TODO: 카카오 로그인
            self?.loginViewModel.kakaoLogin(completion: { result in
                switch result {
                case .success(_):
                    // 프로젝트로 넘기기
                    print("WOW KAKAO Login")
                case .failure(_):
                    //
                    print("WOW KAKAO Can not Login.")
                }
            })
        }
        kakaoLoginButton.addAction(kakaoLoginAction, for: .touchUpInside)
        
        let facebookLoginAction = UIAction { [weak self] _ in
            //TODO: 페이스북 로그인
            if let self = self {
                self.loginViewModel.fbLogin(self) { result in
                    switch result {
                    case .success(_):
                        print("WOW KAKAO Login")
                    case .failure(_):
                        print("WOW FB Can not Login")
                    }
                }
            }
        }
        facebookLoginButton.addAction(facebookLoginAction, for: .touchUpInside)
        
        let emailResisterAction = UIAction { [weak self] _ in
            let signUpViewModel = ResisterEmailViewModel()
            let emailViewController = ResisterEmailViewController(signUpviewModel: signUpViewModel,
                                                          page: .email)
            let navigationController = UINavigationController(rootViewController: emailViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true)
        }
        emailResisterButton.addAction(emailResisterAction, for: .touchUpInside)
        
        let emailLoginAction = UIAction { [weak self] _ in
            let signUpViewModel = ResisterEmailViewModel()
            let logInEmailViewController = LoginEmailViewController(signUpviewModel: signUpViewModel,
                                                                    page: .email)
            let navigationController = UINavigationController(rootViewController: logInEmailViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true)
        }
        emailLoginButton.addAction(emailLoginAction, for: .touchUpInside)
    }
    
    private func setupViews() {
        setupBackground()
        
        let safeArea = view.safeAreaLayoutGuide
        
        [headLabel, subLabel].forEach(labelStackView.addArrangedSubview(_:))
        [emailLoginButton ,emailFlagLabel ,emailResisterButton].forEach(emailLoginButtonStackView.addArrangedSubview(_:))
        [kakaoLoginButton, facebookLoginButton].forEach(loginButtonStackView.addArrangedSubview(_:))
        
        [labelStackView, loginButtonStackView, emailLoginButtonStackView].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            labelStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            
            
            loginButtonStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.15),
            loginButtonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            loginButtonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            loginButtonStackView.bottomAnchor.constraint(equalTo: emailLoginButtonStackView.topAnchor, constant: -10),
            
            emailLoginButtonStackView.topAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -35),
            emailLoginButtonStackView.centerXAnchor.constraint(equalTo: loginButtonStackView.centerXAnchor),
            emailLoginButtonStackView.widthAnchor.constraint(equalTo: loginButtonStackView.widthAnchor, multiplier: 0.8)
            
        ])
    }
    
    private func setupBackground() {
        let background = UIImage(named: "LoginPage")
        var imageView = UIImageView()
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}

