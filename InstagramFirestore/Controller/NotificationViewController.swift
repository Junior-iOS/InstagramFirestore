//
//  NotificationControllerViewController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/10/21.
//

import UIKit

class NotificationViewController: UITableViewController {
    
    // MARK: - Properties
    private var notifications = [Notification]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        fetchNotifications()
    }
    
    private func configureTableView() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.identifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    private func fetchNotifications() {
        NotificationService.fetchNotification { notifications in
            self.notifications = notifications
        }
    }

}

// MARK: - TABLEVIEW DELEGATE / DATASOURCE
extension NotificationViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.identifier, for: indexPath) as? NotificationCell else { return UITableViewCell() }
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        return cell
    }
}
