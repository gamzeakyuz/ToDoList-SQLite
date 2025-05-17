//
//  AppLaunchManager.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 10.05.2025.
//

import Foundation

class AppLaunchManager: ObservableObject {
    @Published var isFirstLaunch: Bool {
        didSet {
            UserDefaults.standard.set(isFirstLaunch, forKey: "isFirstLaunch")
        }
    }

    init() {
        self.isFirstLaunch = UserDefaults.standard.object(forKey: "isFirstLaunch") as? Bool ?? true
    }

    func markWelcomeSeen() {
        isFirstLaunch = false
    }
}
