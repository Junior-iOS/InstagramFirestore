//
//  NotificationViewModel.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 04/12/21.
//

import Foundation
import UIKit

struct NotificationViewModel {
    var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? {  return URL(string: notification.postImageUrl ?? "")  }
    
    var profileImageUrl: URL? { return URL(string: notification.userProfileImageUrl) }
    
    var timestamp: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date())
    }
    
    var notificationMessage: NSAttributedString {
        let userName = notification.userName
        let message = notification.type.notificationMessage
        
        let attributedString = NSMutableAttributedString(string: userName, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedString.append(NSAttributedString(string: " \(timestamp ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return attributedString
    }
    
    var shouldHidePostImage: Bool {
        notification.type == .follow
    }
    
    var folloButtonText: String {
        return notification.isUserFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return notification.isUserFollowed ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return notification.isUserFollowed ? .black : .white
    }
}
