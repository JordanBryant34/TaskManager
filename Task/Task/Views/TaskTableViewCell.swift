//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Jordan Bryant on 9/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func completeButtonTapped(sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var delegate: TaskListTableViewController?
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        nameLabel.text = task?.name
        
        let imageName = (task?.isComplete ?? false) ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
        
        if let dueDate = task?.dueDate, let notes = task?.notes {
            detailLabel.text = "\(dueDate.stringValue()) · \(notes)"
        } else if let dueDate = task?.dueDate {
            detailLabel.text = dueDate.stringValue()
        } else if let notes = task?.notes {
            detailLabel.text = notes
        }
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.completeButtonTapped(sender: self)
    }
}
