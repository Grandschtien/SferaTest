//
//  ViewController.swift
//  SferaTest
//
//  Created by Егор Шкарин on 03.09.2021.
//

import UIKit

class TimerViewController: UIViewController {
    
    private var timers = [Timer]()
    private var isTimerPaused = false
    private let tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.sectionHeaderHeight = 40
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        self.title = "Мульти таймер"
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tableView.tableFooterView = UIView()
        self.setupTableView()
        self.view.addSubview(tableView)
        self.setupConstraintsTableView()
    }
}

//MARK:- Setup Views
extension TimerViewController {
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(AddTimerCell.self, forCellReuseIdentifier: AddTimerCell.reuseId)
        self.tableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.reuseId)
    }
}

//MARK:- Setup Constraints
extension TimerViewController {
    //TableView
    private func setupConstraintsTableView(){
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 0)
        ])
        
    }
}

//MARK:- TableView DataSource

extension TimerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.timers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addCell = AddTimerCell(style: .default, reuseIdentifier: AddTimerCell.reuseId)
        let timerCell = TimerCell(style: .value1, reuseIdentifier: TimerCell.reuseId)
        switch indexPath.section {
        case 0:
            addCell.selectionStyle = .none
            addCell.delegate = self
            return addCell
        case 1:
            guard let state = self.timers[indexPath.row].userInfo as? TimerModel else { return UITableViewCell()}
            timerCell.textLabel?.text = state.name
            timerCell.selectionStyle = .none
            timerCell.detailTextLabel?.text = "\(ValidTimer(seconds: state.seconds).time)"
            return timerCell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : 40
    }
    
    
}
//MARK: TableViewDelegate
extension TimerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0,
                                                        width: tableView.frame.width,
                                                        height: 40))
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0,
                                  width: headerView.frame.width,
                                  height: headerView.frame.height)
        label.backgroundColor = #colorLiteral(red: 0.9483085032, green: 0.9516417543, blue: 0.9616415077, alpha: 1)
        label.font = UIFont(name: "Futura", size: 17)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        switch section {
        case 0:
            label.text = "\tДобавление таймера"
        default:
            label.text = "\tТаймеры"
        }
        label.layer.addBorder(edge: .bottom, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), thickness: 0.5)
        headerView.addSubview(label)
        return headerView
    }
    
}

//MARK:- AddTimerCellDelegate
extension TimerViewController: AddTimerCellDelegate {
    func addTimer(name: String?, seconds: Int?) {
        guard let name = name, let seconds = seconds else {
            self.createAlert()
            return
        }
        let timerModel = TimerModel(name: name, seconds: seconds)
        let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer(_:)),
                                         userInfo: timerModel,
                                         repeats: true)
        self.timers.append(timer)
        self.timers.sort { firstTimer, secondTimer in
            guard let firstState = firstTimer.userInfo as? TimerModel else { return false }
            guard let secondState = secondTimer.userInfo as? TimerModel else { return false}
            return firstState.seconds > secondState.seconds
        }
        self.tableView.reloadData()
    }
}
//MARK:- Timer settings
extension TimerViewController {
    
    @objc private func updateTimer(_ timer: Timer) {
        guard let state = timer.userInfo as? TimerModel else { return }
        state.seconds -= 1
        if state.seconds <= 0 {
            timer.invalidate()
            if let index = timers.firstIndex(of: timer) {
                self.timers.remove(at: index)
            }
        }
        self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
}

extension TimerViewController {
    private func createAlert() {
        let alertController = UIAlertController(title: "Неверные значения", message: "Введите корректные значения", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

