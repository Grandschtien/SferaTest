//
//  ValidTimer.swift
//  SferaTest
//
//  Created by Егор Шкарин on 04.09.2021.
//

import Foundation

class ValidTimer {
    private var hours: Int
    private var minutes: Int
    private var seconds: Int
    
    var time: String {
        get {
            var result = ""
            if self.hours < 10 {
                result = result +  "0" + "\(self.hours)" + ":"
            } else {
                result = result + "\(self.hours)" + ":"
            }
            if self.minutes < 10 {
                result = result +  "0" + "\(self.minutes)" + ":"
            } else {
                result = result + "\(self.minutes)" + ":"
            }
            if self.seconds < 10 {
                result = result +  "0" + "\(self.seconds)"
            } else {
                result = result + "\(self.seconds)"
            }
            return result
        }
    }
    
    init(seconds: Int) {
        self.hours = seconds / 3600
        self.minutes = (seconds % 3600) / 60
        self.seconds = (seconds % 3600) % 60
    }
}
