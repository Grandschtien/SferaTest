//
//  TimerCell.swift
//  SferaTest
//
//  Created by Егор Шкарин on 04.09.2021.
//

import UIKit

class TimerCell: UITableViewCell {
    
    static let reuseId = "TimerCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
