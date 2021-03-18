//
//  HabitsDetailsTableViewHeader.swift
//  MyHabits
//
//  Created by Mihail on 17.03.2021.
//

import UIKit

class HabitsDetailsTableViewHeader: UITableViewHeaderFooterView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .systemGray
        label.text = "Активность"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemGray2
        contentView.addSubview(titleLabel)
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}
