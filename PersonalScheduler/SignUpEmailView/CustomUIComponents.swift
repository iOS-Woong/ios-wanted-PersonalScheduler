//
//  CustomComponents.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/09.
//

import UIKit

// MARK: 라벨
class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = .boldSystemFont(ofSize: 22)
        self.textColor = .black
        self.numberOfLines = 0
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 텍스트필드
class CustomTextFiled: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = .black
        self.borderStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 버튼
class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .facebookColor
        self.setTitleColor(.white, for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
