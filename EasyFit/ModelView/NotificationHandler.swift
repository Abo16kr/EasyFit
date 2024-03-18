//
//  NotificationHandler.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 18.03.2024.
//

import Foundation
import UserNotifications


class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func enableNotifications() {
        scheduleDailyNotifications()
    }

    func disableNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
    }

    // Existing sendNotification method...

    func scheduleDailyNotifications() {
        // Schedule morning notification at 8:00 AM
        let morningDateComponents = DateComponents(hour: 8, minute: 0)
        scheduleNotification(at: morningDateComponents, title: "Good Morning!", body: "Start your day with a fresh mood.")

        // Schedule evening notification at 10:00 PM
        let eveningDateComponents = DateComponents(hour: 22, minute: 0)
        scheduleNotification(at: eveningDateComponents, title: "Good Evening!", body: "Time to relax and prepare for tomorrow.")
    }
    
    private func scheduleNotification(at dateComponents: DateComponents, title: String, body: String) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled: \(title) at \(dateComponents.hour!):\(dateComponents.minute!)")
            }
        }
    }
}

