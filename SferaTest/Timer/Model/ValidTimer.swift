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
            if hours < 10 {
                result = result +  "0" + "\(hours)" + ":"
            } else {
                result = result + "\(hours)" + ":"
            }
            if minutes < 10 {
                result = result +  "0" + "\(minutes)" + ":"
            } else {
                result = result + "\(minutes)" + ":"
            }
            if seconds < 10 {
                result = result +  "0" + "\(seconds)"
            } else {
                result = result + "\(seconds)"
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
