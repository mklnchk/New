//
//  Model.swift
//  ToDoList
//
//  Created by Catherine Volohova on 08.12.2020.
//

import Foundation
import UserNotifications
import UIKit

var ToDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoKey") as? [[String: Any]] {
            return array
        } else {
            return []
        }
      
    }
}

func addItems (nameItems: String, isCompleted: Bool = false) {
    ToDoItems.append(["Name": nameItems, "isCompleted": isCompleted])
    createBage() 
}

func removeItems(at index: Int) {
    ToDoItems.remove(at: index)
    createBage()
}

func moveItem (fromIndex: Int, toIndex: Int){
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
}

func changeState(at item: Int) -> Bool {
    ToDoItems[item]["isCompleted"] =
        !(ToDoItems[item]["isCompleted"] as! Bool)
    
    createBage()
    
    return ToDoItems[item]["isCompleted"] as! Bool
}

func notificationRequest() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) {
    (isEnabled, error) in
        if isEnabled {
            print("Уведомления включены")
        } else {
            print("Уведомления отключены")
        }
    }
}
func createBage() {
    var totalNumber = 0
    for item in ToDoItems {
        if (item["isCompleted"] as? Bool) == false {
            totalNumber = totalNumber + 1
        
        }
    }
    
    UIApplication.shared.applicationIconBadgeNumber = totalNumber
}
