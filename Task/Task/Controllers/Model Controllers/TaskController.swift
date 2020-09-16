//
//  TaskController.swift
//  Task
//
//  Created by Jordan Bryant on 9/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] {
        return fetchTasks()
    }
    
    func addTaskWith(name: String, notes: String?, dueDate: Date?) {
        _ = Task(name: name, dueDate: dueDate, notes: notes, isComplete: false)
        saveToPersistentStore()
    }
    
    func updateTask(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistentStore()
    }
    
    func removeTask(task: Task) {
        if let moc = task.managedObjectContext {
            moc.delete(task)
            saveToPersistentStore()
        }
    }
    
    func toggleComplete(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    func fetchTasks() -> [Task] {
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        return (try? moc.fetch(fetchRequest)) ?? []
    }
}
