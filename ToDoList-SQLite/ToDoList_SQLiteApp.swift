//
//  ToDoList_SQLiteApp.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 9.05.2025.
//

import SwiftUI

@main
struct ToDoList_SQLiteApp: App {
    
    @State var todoViewModel: ToDoViewModel = ToDoViewModel()
    @StateObject var launchManager = AppLaunchManager()
    
    var body: some Scene {
//        WindowGroup {
//            NavigationView {
//                TodoView()
//            }
//            .environmentObject(todoViewModel)
//        }
        WindowGroup {
            if launchManager.isFirstLaunch {
                WelcomeView(launchManager: launchManager)
            } else {
                NavigationView {
                    TodoView()
                }
                .environmentObject(todoViewModel)
            }
        }
        
    }
}
