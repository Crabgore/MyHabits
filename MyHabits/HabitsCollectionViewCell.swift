//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Mihail on 17.03.2021.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    var habits: Habit? {
        didSet {
            titleLabel.text = habits?.name
            titleLabel.textColor = habits?.color
            timeLabel.text = habits?.dateString
            if habits!.isAlreadyTakenToday {
                colorCircle.backgroundColor = habits?.color
                colorCircleImage.image = UIImage(systemName: "checkmark")
                colorCircleImage.tintColor = .white
                colorCircle.layer.borderWidth = 0
                colorCircle.layer.borderColor = .none
            } else {
                colorCircleImage.image = nil
                colorCircleImage.backgroundColor = .none
                colorCircle.layer.borderWidth = 1
                colorCircle.backgroundColor = .white
                colorCircle.layer.borderColor = habits?.color.cgColor
            }
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let colorCircle: UIView = {
        let label = UIView()
        label.clipsToBounds = true
        label.layer.cornerRadius = 36/2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let colorCircleImage: UIImageView = {
        let label = UIImageView()
        label.clipsToBounds = true
        label.layer.cornerRadius = 24/2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(colorCircle)
        contentView.addSubview(colorCircleImage)
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            colorCircle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 47),
            colorCircle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            colorCircle.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -47),
            colorCircle.widthAnchor.constraint(equalToConstant: 36),
            colorCircle.heightAnchor.constraint(equalToConstant: 36),
            
            colorCircleImage.topAnchor.constraint(equalTo: colorCircle.topAnchor, constant: 6),
            colorCircleImage.leadingAnchor.constraint(equalTo: colorCircle.leadingAnchor, constant: 6),
            colorCircleImage.trailingAnchor.constraint(equalTo: colorCircle.trailingAnchor, constant: -6),
            colorCircleImage.bottomAnchor.constraint(equalTo: colorCircle.bottomAnchor, constant: -6),
            colorCircleImage.widthAnchor.constraint(equalToConstant: 24),
            colorCircleImage.heightAnchor.constraint(equalToConstant: 24)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
