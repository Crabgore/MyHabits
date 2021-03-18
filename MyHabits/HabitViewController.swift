//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Mihail on 16.03.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habit: Habit? {
        didSet {
            if habit != nil {
                titleTF.text = habit!.name
                colorCircle.backgroundColor = habit!.color
                datePicker.date = habit!.date
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    var viewDelegate: RefreshDataDelegate?
    var popBackDelegate: PopBackDelegate?
    
    private let navBar: UINavigationBar = {
        let label = UINavigationBar()
        let navItem = UINavigationItem(title: "Создать")
        let doneItem = UIBarButtonItem(title: "Отменить", style: .done, target: self, action: #selector(closeTap))
        let saveItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveTap))
        navItem.leftBarButtonItem = doneItem
        navItem.rightBarButtonItem = saveItem
        label.setItems([navItem], animated: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.text = "НАЗВАНИЕ"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleTF: UITextField = {
        let label = UITextField()
        label.placeholder = "Бегать по утрам, спать 8 часов и т.д."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.text = "ЦВЕТ"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorCircle: UIView = {
        let label = UIView()
        label.backgroundColor = .red
        label.clipsToBounds = true
        label.layer.cornerRadius = 30/2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.text = "ВРЕМЯ"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Каждый день в "
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let label = UIDatePicker()
        label.datePickerMode = .time
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deleteHabbitButton: UIButton = {
        let label = UIButton()
        label.setTitle("Удалить привычку", for: .normal)
        label.setTitleColor(.red, for: .normal)
        label.addTarget(self, action: #selector(showAlert(_:)), for: .touchUpInside)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(navBar)
        view.addSubview(titleLabel)
        view.addSubview(titleTF)
        view.addSubview(colorLabel)
        view.addSubview(colorCircle)
        view.addSubview(timeLabel)
        view.addSubview(firstTimeLabel)
        view.addSubview(datePicker)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(pickColor))
        colorCircle.addGestureRecognizer(recognizer)
        
        var constraints = [
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 64),
            
            titleLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            titleTF.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            titleTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            colorLabel.topAnchor.constraint(equalTo: titleTF.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            colorCircle.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorCircle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorCircle.widthAnchor.constraint(equalToConstant: 30),
            colorCircle.heightAnchor.constraint(equalToConstant: 30),

            timeLabel.topAnchor.constraint(equalTo: colorCircle.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            firstTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            firstTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            datePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            datePicker.leadingAnchor.constraint(equalTo: firstTimeLabel.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: firstTimeLabel.bottomAnchor)
        ]
        
        if habit != nil {
            view.addSubview(deleteHabbitButton)
            constraints.append(deleteHabbitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
            constraints.append(deleteHabbitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(deleteHabbitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func closeTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTap() {
        print("datepicker \(datePicker.date)")
        let store = HabitsStore.shared
        
        if habit != nil {
            for (index, _) in store.habits.enumerated() {
                if store.habits[index].name == habit!.name {
                    store.habits[index].name = titleTF.text ?? store.habits[index].name
                    store.habits[index].date = datePicker.date
                    store.habits[index].color = colorCircle.backgroundColor ?? store.habits[index].color
                    store.save()
                    break
                }
            }
        } else {
            let newHabit = Habit(name: titleTF.text ?? "",
                                 date: datePicker.date,
                                 color: colorCircle.backgroundColor ?? .systemRed)
            store.habits.append(newHabit)
        }
        
        viewDelegate?.refreshData()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pickColor(gestureRecognizer: UITapGestureRecognizer) {
        let picker = UIColorPickerViewController()
        picker.selectedColor = .red
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Удалить привычку?", message: "Вы хотите удалить привычку \(habit!.name)?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            if let index = HabitsStore.shared.habits.firstIndex(of: self.habit!) {
                HabitsStore.shared.habits.remove(at: index)
                HabitsStore.shared.save()
                self.popBackDelegate?.popBack()
                self.dismiss(animated: true, completion: nil)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorCircle.backgroundColor = viewController.selectedColor
        viewController.dismiss(animated: true, completion: nil)
    }
}

protocol RefreshDataDelegate {
  func refreshData()
}

protocol PopBackDelegate {
  func popBack()
}
