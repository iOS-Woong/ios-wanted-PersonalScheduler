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
        
    init(signUpviewModel: SignUpViewModel, page: Page)
}

extension UserInputable {
    
    func nextTo() {
        
    }
    
    
}
