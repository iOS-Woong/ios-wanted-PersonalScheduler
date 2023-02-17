//
//  BoardingRecordTableViewCell.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/15.
//

import UIKit

class BoardingRecordTableViewCell: UITableViewCell, ReusableView {
    
    enum Constant {
        static let date = "날짜 "
        static let driveTime = "운행시간 "
        static let callType = "호출 "
        static let startLocation = "출발 "
        static let endLocation = "도착 "
        static let fare = "금액 "
    }
    
    var carTypeImage: UIImageView = {
       let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var carTypeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var deleteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    var dateLabel: UILabel = {
     let label = UILabel()
                
        return label
    }()
    
    var driveTimeLabel: UILabel = {
     let label = UILabel()
                
        return label
    }()
    
    var callTypeLabel: UILabel = {
     let label = UILabel()
        return label
    }()
    
    var startLocationLabel: UILabel = {
     let label = UILabel()
        return label
    }()
    
    var endLocationLabel: UILabel = {
     let label = UILabel()
        return label
    }()
    
    var fareLabel: UILabel = {
     let label = UILabel()
        return label
    }()
    
    
    let boardingHistoryStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabelsToAttributeString(
            labels: [dateLabel, driveTimeLabel, callTypeLabel, startLocationLabel, endLocationLabel, fareLabel]
        )
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: BoardingHistory) {
        carTypeImage.image = data.carType.imageDescription
        carTypeLabel.text = data.carType.labelDescription
        driveTimeLabel.text = Constant.driveTime + data.driveTime
        dateLabel.text = Constant.date + data.date.description
        callTypeLabel.text = Constant.callType + data.callType.labelDescription
        startLocationLabel.text = Constant.startLocation + data.startLocation
        endLocationLabel.text = Constant.endLocation + data.endLocation
        fareLabel.text = Constant.fare + data.fare.description
    }
    
    private func setupLabelsToAttributeString(labels: [UILabel]) {
        labels.forEach { setupAttributeStringLabel(label: $0) }
    }
    
    private func setupAttributeStringLabel(label: UILabel) {
//        guard let labelText = label.text else { return }
        let fontSize = UIFont.boldSystemFont(ofSize: 11)
        let attributedStr = NSMutableAttributedString(string: Constant.fare)
        attributedStr.addAttribute(.font, value: fontSize, range: (Constant.fare as NSString).range(of: Constant.fare))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.systemGray, range: (Constant.fare as NSString).range(of: Constant.fare))
        label.attributedText = attributedStr
    }
    
    private func setupViews() {
        [dateLabel, driveTimeLabel, callTypeLabel, startLocationLabel, endLocationLabel, fareLabel].forEach(boardingHistoryStackView.addArrangedSubview(_:))
        [carTypeImage, carTypeLabel, deleteButton, boardingHistoryStackView].forEach(addSubview(_:))
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            carTypeImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            carTypeImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            carTypeImage.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.08),
            carTypeImage.heightAnchor.constraint(equalTo: carTypeImage.widthAnchor),
            
            carTypeLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            carTypeLabel.leadingAnchor.constraint(equalTo: carTypeImage.trailingAnchor, constant: 5),
            
            deleteButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            deleteButton.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.06),
            deleteButton.heightAnchor.constraint(equalTo: deleteButton.widthAnchor),
            
            boardingHistoryStackView.topAnchor.constraint(equalTo: carTypeLabel.bottomAnchor, constant: 10),
            boardingHistoryStackView.leadingAnchor.constraint(equalTo: carTypeLabel.leadingAnchor),
            boardingHistoryStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
}
