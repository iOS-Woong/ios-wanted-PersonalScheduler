//
//  EmailViewController.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import UIKit

class EmailViewController: UIViewController, UserInputable {
    
    enum Constant {
        static let message =
                            """
                            안녕하세요!
                            로그인에 사용할 이메일을 입력해주세요.
                            """
        static let placeholder = "workplayhard1@naver.com"
        static let buttonTitle = "다음"
    }
    
    var signUpViewModel: SignUpViewModel
    
    var descriptionLabel: CustomLabel = {
        let label = CustomLabel()
        
        label.text = Constant.message
        
        return label
    }()
    
    var userInformationInputTextFiled: CustomTextFiled = {
        let textField = CustomTextFiled()
        
        textField.placeholder = Constant.placeholder
        textField.keyboardType = UIKeyboardType.emailAddress

        return textField
    }()
    
    var actionButton: CustomButton = {
        let button = CustomButton()
        
        button.setTitle(Constant.buttonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let labelAndTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    required init(signUpviewModel: SignUpViewModel) {
        self.signUpViewModel = SignUpViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInformationInputTextFiled.becomeFirstResponder()
        setupNavigation()
        addObserver()
        setupViews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTextFieldBottomBorder(isTouched: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeObserver()
    }
    
    private func setupNavigation() {
        let closeAction = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let buttonImage = UIImage(systemName: "multiply")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: buttonImage,
                                                           primaryAction: closeAction)
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupTextFieldBottomBorder(isTouched: Bool) {
        let border = CALayer()
        border.frame = CGRect(x: 0,
                              y: userInformationInputTextFiled.frame.size.height + 5,
                              width: userInformationInputTextFiled.frame.width,
                              height: 2)
        let colorValue = isTouched ?  UIColor.facebookColor.cgColor : UIColor.lightGray.cgColor
        border.backgroundColor = colorValue
        userInformationInputTextFiled.layer.addSublayer(border)
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        [descriptionLabel, userInformationInputTextFiled].forEach(labelAndTextFieldStackView.addArrangedSubview(_:))
        [labelAndTextFieldStackView, actionButton].forEach(view.addSubview(_:))
                
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            labelAndTextFieldStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            labelAndTextFieldStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            labelAndTextFieldStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15)
        ])
    }
}

// MARK: Notification
extension EmailViewController {
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        handleButtonConstraint(notification, isAppearing: true)
    }
    
    private func handleButtonConstraint(_ notification: Notification, isAppearing: Bool) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                  as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        guard let superView = view.superview else { return }
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -keyboardHeight),
            actionButton.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.06)
        ])
    }
}
