//
//  EmailResisterable.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import UIKit

protocol UserInputable {
    var signUpViewModel: SignUpViewModel { get }
    var page: Page { get }
    var descriptionLabel: CustomLabel { get }
    var userInformationInputTextFiled: CustomTextFiled { get }
    var actionButton: CustomButton { get }
    var labelAndTextFieldStackView: UIStackView { get }
    
    func bind()
    func addObserver()
    func removeObserver()
    func keyboardWillShow(_ notification: Notification)
    
    init(signUpviewModel: SignUpViewModel, page: Page)
}
