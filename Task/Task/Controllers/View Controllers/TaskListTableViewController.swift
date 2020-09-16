//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Jordan Bryant on 9/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    let taskController = TaskController.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellId") as! TaskTableViewCell
        let task = taskController.tasks[indexPath.row]
        
        cell.task = task
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = taskController.tasks[indexPath.row]
            taskController.removeTask(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskController.tasks.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let detailVC = segue.destination as? TaskDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let task = taskController.tasks[indexPath.row]
            
            detailVC.task = task
        }
    }
}

extension TaskListTableViewController: TaskCellDelegate {
    func completeButtonTapped(sender: TaskTableViewCell) {
        guard let task = sender.task else { return }
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        taskController.toggleComplete(task: task)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
