//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Mihail on 17.03.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController, PopBackDelegate {
    func popBack() {
        navigationController?.popViewController(animated: true)
    }
    
    var myTitle = ""
    var habit: Habit?
    var dates: [Date]?
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .systemGray
        label.text = "Активность"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editTap))
        setupTableView()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.title = myTitle
        
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = self
        tableView.register(
            HabitDetailTableViewCell.self,
            forCellReuseIdentifier: String(describing: HabitDetailTableViewCell.self)
        )
    }
    
    @objc func editTap() {
        let controller = HabitViewController()
        controller.habit = habit
        controller.popBackDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("dates count \(dates!.count)")
        return dates!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HabitDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailTableViewCell.self), for: indexPath) as! HabitDetailTableViewCell
        cell.index = indexPath.row
        cell.habit = habit
        return cell
    }
}
