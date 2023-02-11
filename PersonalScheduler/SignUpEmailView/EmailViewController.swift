//
//  EmailViewController.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import UIKit

class EmailViewController: UIViewController, UserInputable {
    
    enum Constant {
        static let whiteSpace = ""
    }
    
    var signUpViewModel: SignUpViewModel
    var page: Page
    
    var descriptionLabel: CustomLabel = {
        let label = CustomLabel()
        return label
    }()
    
    var userInformationInputTextFiled: CustomTextFiled = {
        let textField = CustomTextFiled()
        return textField
    }()
    
    var actionButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        
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
    
    required init(signUpviewModel: SignUpViewModel, page: Page) {
        self.signUpViewModel = signUpviewModel
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        setupButton()
        setupPageDescription()
        setupNavigation()
        setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTextFieldBottomBorder(isTouched: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    private func bind() {
        signUpViewModel.inputInformation?.bind(listener: { userInfo in
            // firebase Create
        })
    }
    
    
    private func setupPageDescription() {
        descriptionLabel.text = page.messageDescription
        userInformationInputTextFiled.placeholder = page.placeholderDescription
        userInformationInputTextFiled.keyboardType = page.keyboardTypeDescription
        actionButton.setTitle(page.buttonTitleDescription, for: .normal)
    }
    
    private func setupNavigation() {
        title = Constant.whiteSpace
        
        let closeAction = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let buttonImage = UIImage(systemName: "multiply")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: buttonImage,
                                                           primaryAction: closeAction)
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupButton() {
        let nextAction = UIAction { [weak self] _ in
            guard let self = self,
                  let textField = self.userInformationInputTextFiled.text else { return }
            self.signUpViewModel.loadUserInputInformation(page: self.page,
                                                          textField: textField)
            self.sceneConversion()
        }
        actionButton.addAction(nextAction, for: .touchUpInside)
    }
    
    private func sceneConversion() {
        let nextPageRawValue = self.page.rawValue + 1
        if nextPageRawValue == 3 {
            self.dismiss(animated: true)
            return
        }
        let emailViewController = EmailViewController(signUpviewModel: self.signUpViewModel,
                                                      page: Page(rawValue: nextPageRawValue) ?? .email)
        self.navigationController?.pushViewController(emailViewController, animated: true)
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
        actionButton.isHidden = false
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
