//
//  ViewController.swift
//  SferaTest
//
//  Created by Егор Шкарин on 03.09.2021.
//

import UIKit

class TimerViewController: UIViewController {
    
    private let staticLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.9483085032, green: 0.9516417543, blue: 0.9616415077, alpha: 1)
        label.font = UIFont(name: "Futura", size: 17)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.text = "  Добавление таймера"
        return label
    }()
    
    private var textStackView: UIStackView!
    
    private let nameOfTimerTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название таймера"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let setTimerTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Время в секундах"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9192961785, green: 0.9283981209, blue: 0.9283981209, alpha: 1)
        button.layer.cornerRadius = 20
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.07163762073, green: 0.3562414179, blue: 1, alpha: 1), for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    private let tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.sectionHeaderHeight = 40
        return table
    }()
    private func setupVC() {
        title = "Мульти таймер"
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        self.view.addSubview(staticLabel)
//        setupStaticLabelConstraints()
//        setupTextStackView()
//        self.view.addSubview(textStackView)
//        setupTextStackViewConstraints()
//        setupAddButton()
//        self.view.addSubview(addButton)
//        setupConstraintsAddButton()
        setupTableView()
        self.view.addSubview(tableView)
        setupConstraintsTableView()
    }
}

//MARK:- Setup Views
extension TimerViewController {
    private func setupTextStackView() {
        textStackView = UIStackView(arrangedSubviews: [nameOfTimerTF, setTimerTF])
        textStackView.axis = .vertical
        textStackView.spacing = 15
        textStackView.alignment = .fill
        textStackView.distribution = .fill
    }
    
    private func setupAddButton() {
        addButton.addTarget(self, action: #selector(addButtonAction(sender:)), for: .touchUpInside)
    }
    
    @objc private func addButtonAction(sender: UIButton) {
        print("addButtonAction")
    }
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AddTimerCell.self, forCellReuseIdentifier: "AddCell")
    }
}

//MARK:- Setup Constraints
extension TimerViewController {
    // StackView
    private func setupStaticLabelConstraints() {
        self.staticLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.staticLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 50),
            self.staticLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                       constant: 0),
            self.staticLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                      constant: 0),
            self.staticLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    //TextFields
    private func setupTextStackViewConstraints() {
        self.textStackView.translatesAutoresizingMaskIntoConstraints = false
        let verticalSpaceToStaticLabel = NSLayoutConstraint(item: self.textStackView!, attribute: .top, relatedBy: .equal, toItem: self.staticLabel, attribute: .top, multiplier: 1, constant: 60)
        
        NSLayoutConstraint.activate([
            verticalSpaceToStaticLabel,
            self.textStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                         constant: -100),
            self.textStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
    }
    //Button
    private func setupConstraintsAddButton() {
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        let verticalSpace = NSLayoutConstraint(item: self.textStackView!, attribute: .bottom, relatedBy: .equal, toItem: self.addButton, attribute: .bottom, multiplier: 1, constant: -100)
        NSLayoutConstraint.activate([
            verticalSpace,
            self.addButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                     constant: -20),
            self.addButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                    constant: 20),
            self.addButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    //TableView
    private func setupConstraintsTableView(){
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
       // let verticalSpace = NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self.addButton, attribute: .top, multiplier: 1, constant: 30)
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
        switch section {
        case 0:
            return 1
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addCell = AddTimerCell(style: .default, reuseIdentifier: "AddCell")
        let timerCell = UITableViewCell(style: .value1, reuseIdentifier: "TimerCell")
        switch indexPath.section {
        case 0:
            addCell.selectionStyle = .none
            return addCell
        default:
            timerCell.textLabel?.text = "Timer \(indexPath.row)"
            timerCell.detailTextLabel?.text = "00:00"
            return timerCell
        }
      
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 200
        default:
            return 40
        }
    }
    
    
}

extension TimerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))

        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        label.backgroundColor = #colorLiteral(red: 0.9483085032, green: 0.9516417543, blue: 0.9616415077, alpha: 1)
        label.font = UIFont(name: "Futura", size: 17)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        switch section {
        case 0:
            label.text = "    Добавление таймеров"
        default:
            label.text = "    Таймеры"
        }
        label.layer.addBorder(edge: .bottom, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), thickness: 0.5)
        headerView.addSubview(label)
        return headerView
    }
}
