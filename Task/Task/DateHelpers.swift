//
//  DateHelpers.swift
//  Task
//
//  Created by Jordan Bryant on 9/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
