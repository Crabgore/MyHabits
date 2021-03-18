//
//  HabitDetailTableViewCell.swift
//  MyHabits
//
//  Created by Mihail on 17.03.2021.
//

import UIKit

class HabitDetailTableViewCell: UITableViewCell {
    
    var index: Int? {
        didSet {
            dateLabel.text = HabitsStore.shared.trackDateString(forIndex: index!)
        }
    }
    
    var habit: Habit? {
        didSet {
            if HabitsStore.shared.habit(habit!, isTrackedIn: HabitsStore.shared.dates[index!]) {
                doneImage.image = UIImage(systemName: "checkmark")
            }
        }
    }

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doneImage: UIImageView = {
        let label = UIImageView()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(doneImage)
        
        let constraints = [
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            doneImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            doneImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            doneImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
