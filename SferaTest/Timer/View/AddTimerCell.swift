//
//  AddTimerCell.swift
//  SferaTest
//
//  Created by Егор Шкарин on 03.09.2021.
//

import UIKit

class AddTimerCell: UITableViewCell {

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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextStackView()
        self.addSubview(textStackView)
        self.addSubview(addButton)
        setupTextStackViewConstraints()
        setupConstraintsAddButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextStackView() {
        textStackView = UIStackView(arrangedSubviews: [nameOfTimerTF, setTimerTF])
        textStackView.axis = .vertical
        textStackView.spacing = 15
        textStackView.alignment = .fill
        textStackView.distribution = .fill
    }

}
//MARK:- Constraints
extension AddTimerCell {
    //StackView
    private func setupTextStackViewConstraints() {
        self.textStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.textStackView!,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self.addButton,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: -80),
            self.textStackView.topAnchor.constraint(equalTo: self.topAnchor,
                                                    constant: 20),
            self.textStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                        constant: 20),
            self.textStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                         constant: -100)
           
        ])
    }
    //Button
    private func setupConstraintsAddButton() {
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                     constant: -20),
            self.addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                    constant: 20),
            self.addButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
