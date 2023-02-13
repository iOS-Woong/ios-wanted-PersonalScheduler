//
//  LoginEmailViewController.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/14.
//

import UIKit

enum EmailLoginPage {
    case email
    case password
}

class LoginEmailViewController: UIViewController {
    
    let loginEmailViewModel: LoginEmailViewModel
    let emailLoginPage: EmailLoginPage
    
    let descriptionLabel = {
        let label = CustomLabel()
        
        return label
    }()
    
    let emailTextField = {
        let textField = CustomTextFiled()
        
        return textField
    }()
    
    let passwordTextField = {
        let textField = CustomTextFiled()
        
        return textField
    }()
    
    let resultLabel = {
        let label = UILabel()
        
        return label
    }()
    
    let actionButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init(loginEmailViewModel: LoginEmailViewModel, emailLoginPage: EmailLoginPage) {
        self.loginEmailViewModel = loginEmailViewModel
        self.emailLoginPage = emailLoginPage
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTextField()
    }
    
    
    func setupTextField() {
        emailTextField.setupTextFieldBottomBorder()
        passwordTextField.setupTextFieldBottomBorder()
    }
    
    func setupViews() {
        
    }
    
}
