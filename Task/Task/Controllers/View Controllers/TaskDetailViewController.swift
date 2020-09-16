//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Jordan Bryant on 9/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class TaskDetailViewController: UITableViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    let taskController = TaskController.shared
    
    var task: Task?
    var dueDateValue: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissEditing))
        view.addGestureRecognizer(tap)
        
        dueDateTextField.inputView = dueDatePicker
        
        title = "New Task"
        if let task = task {
            title = "View Task"
            taskNameTextField.text = task.name
            notesTextView.text = task.notes ?? ""
            
            if let dueDate = task.dueDate {
                dueDateValue = dueDate
                dueDateTextField.text = dueDate.stringValue()
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else { return }
        
        var dueDate: Date? = nil
        var notes: String? = nil
        
        if dueDateTextField.hasText { dueDate = dueDatePicker.date }
        if notesTextView.hasText && notesTextView.text != "Enter task notes here..." { notes = notesTextView.text }
        
        if let task = task {
            taskController.updateTask(task: task, name: name, notes: notes, dueDate: dueDate)
        } else {
            taskController.addTaskWith(name: name, notes: notes, dueDate: dueDate)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = sender.date
        dueDateTextField.text = sender.date.stringValue()
    }
    
    @objc func dismissEditing() {
        view.endEditing(true)
    }
}
