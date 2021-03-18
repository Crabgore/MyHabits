//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Mihail on 16.03.2021.
//

import UIKit

class HabitsViewController: UIViewController, RefreshDataDelegate {
    
    func refreshData() {
        collectionView.reloadData()
        collectionView.setNeedsDisplay()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        collectionView.setNeedsDisplay()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // default is .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            HabitsCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HabitsCollectionViewCell.self)
        )
        collectionView.register(
            HabitsCollectionViewHeaderCell.self,
            forCellWithReuseIdentifier: String(describing: HabitsCollectionViewHeaderCell.self))
        collectionView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        return collectionView
    }()
    
    @IBAction func addHabit(_ sender: Any) {
        let controller = HabitViewController()
        controller.viewDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func coloredCircleTap(_ sender: UITapGestureRecognizer) {
        print("TAPPED")
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            print("Got clicked on index: \(index[1])!")
            
            if !HabitsStore.shared.habits[index[1]].isAlreadyTakenToday {
                let habit = HabitsStore.shared.habits[index[1]]
                let cell = collectionView.cellForItem(at: index) as! HabitsCollectionViewCell
                cell.colorCircle.backgroundColor = habit.color
                cell.colorCircleImage.image = UIImage(systemName: "checkmark")
                cell.colorCircleImage.tintColor = .white
                HabitsStore.shared.track(habit)
            }
        }
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: HabitsCollectionViewHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitsCollectionViewHeaderCell.self), for: indexPath) as! HabitsCollectionViewHeaderCell
            return cell
        } else {
            let cell: HabitsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitsCollectionViewCell.self), for: indexPath) as! HabitsCollectionViewCell
            cell.colorCircle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(coloredCircleTap(_:))))
            return cell
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    var inset: CGFloat { return 12 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: (collectionView.frame.width - 32), height: 60)
        } else {
            return CGSize(width: (collectionView.frame.width - 32), height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let headerCell = cell as? HabitsCollectionViewHeaderCell else { return }
            headerCell.progress = HabitsStore.shared.todayProgress
        } else {
            guard let habitCell = cell as? HabitsCollectionViewCell else { return }
            habitCell.habit = HabitsStore.shared.habits[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let controller = HabitDetailsViewController()
            controller.myTitle = HabitsStore.shared.habits[indexPath.row].name
            controller.dates = HabitsStore.shared.dates
            print("dates \(HabitsStore.shared.dates)")
            controller.habit = HabitsStore.shared.habits[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }

}
