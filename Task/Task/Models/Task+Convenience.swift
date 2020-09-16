//
//  Task+Convenience.swift
//  Task
//
//  Created by Jordan Bryant on 9/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    convenience init(name: String, dueDate: Date?, notes: String?, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.dueDate = dueDate
        self.notes = notes
        self.isComplete = isComplete
    }
}
