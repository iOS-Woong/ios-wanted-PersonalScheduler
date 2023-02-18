//
//  LoginEmailViewController.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/14.
//

import UIKit
import FirebaseAuth
import Vision


class LoginEmailViewController: UIViewController, UserInputable {
    
    enum Constant {
        static let whiteSpace = ""
    }
    
    var signUpViewModel: ResisterEmailViewModel
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
    
    var labelAndTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.center = self.view.center
        indicator.style = .large
        indicator.startAnimating()
        indicator.isHidden = true
        
        return indicator
    }()

    required init(signUpviewModel: ResisterEmailViewModel, page: Page) {
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
        // bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userInformationInputTextFiled.setupTextFieldBottomBorder(mode: true)
    }
    
    func bind() {
        signUpViewModel.inputInformation?.bind(listener: { [weak self] _ in
            guard let self = self,
                  let inputInfo = self.signUpViewModel.inputInformation?.value else { return }

            self.signUpViewModel.signIn(email: inputInfo.email, pw: inputInfo.password) { [weak self] result in
                switch result {
                case .success(_):
                    self?.presentTabbarController()
                case .failure(_):
                    self?.userInformationInputTextFiled.setupTextFieldBottomBorder(mode: false)
                    self?.activityIndicator.isHidden = true
                }
            }
        })
    }
    
    
    private func setupPageDescription() {
        descriptionLabel.text = page.loginMessageDescription
        userInformationInputTextFiled.placeholder = page.placeholderDescription
        userInformationInputTextFiled.keyboardType = page.keyboardTypeDescription
        actionButton.setTitle(page.loginButtonTitleDescription, for: .normal)
    }
    
    func setupButton() {
        let nextAction = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.checkSignInableLogin()
            self.activityIndicator.isHidden = false
//            self.userInformationInputTextFiled.setupTextFieldBottomBorder(mode: false)
        }
        actionButton.addAction(nextAction, for: .touchUpInside)
    }
    
    private func checkSignInableLogin() {
        guard let inputText = userInformationInputTextFiled.text else { return }
        switch page {
        case .email:
            signUpViewModel.signInableEmail(email: inputText) {
                self.signUpViewModel.loadUserInputInformation(page: self.page,
                                                              textField: inputText)
                self.sceneConversion()
            }
        case .pw:
            signUpViewModel.loadUserInputInformation(page: page,
                                                     textField: inputText)
            bind()
        }
    }
    
    private func sceneConversion() {
        if page != .pw {
            let loginEmailViewController = LoginEmailViewController(signUpviewModel: self.signUpViewModel,
                                                                    page: .pw)
            self.navigationController?.pushViewController(loginEmailViewController, animated: true)
        }
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
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        [descriptionLabel, userInformationInputTextFiled].forEach(labelAndTextFieldStackView.addArrangedSubview(_:))
        [labelAndTextFieldStackView, actionButton, activityIndicator].forEach(view.addSubview(_:))
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            labelAndTextFieldStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            labelAndTextFieldStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            labelAndTextFieldStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15)
        ])
    }
    
}

// MARK: Notification
extension LoginEmailViewController {
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        actionButton.isHidden = false
        handleButtonConstraint(notification, isAppearing: true)
    }
    
    func handleButtonConstraint(_ notification: Notification, isAppearing: Bool) {
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

extension LoginEmailViewController {
    private func presentTabbarController() {
        let boardingRecordViewModel = BoardingRecordViewModel()
        let boardingRecordViewController = BoardingRecordViewController(boardingRecordViewModel: boardingRecordViewModel)
        let boardingRecordNavigationViewController = UINavigationController(rootViewController: boardingRecordViewController)
        
        let boardingAllocationViewModel = BoardingAllocationViewModel()
        let boardingAllocationViewController = BoardingAllocationViewController(boardingAllocationViewModel: boardingAllocationViewModel)
        
        let tabbarController = UITabBarController()
        tabbarController.setViewControllers([boardingAllocationViewController, boardingRecordNavigationViewController], animated: false)
        
        
        boardingRecordNavigationViewController.tabBarItem = UITabBarItem(title: "운행기록", image: nil, selectedImage: nil)
        boardingAllocationViewController.tabBarItem = UITabBarItem(title: "배차", image: nil, selectedImage: nil)
        
        tabbarController.modalPresentationStyle = .fullScreen
        self.present(tabbarController, animated: true, completion: {
            self.activityIndicator.isHidden = true
        })
    }
}
