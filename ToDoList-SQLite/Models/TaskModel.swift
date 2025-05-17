//
//  TaskModel.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 9.05.2025.
//

import Foundation

struct TaskModel: Identifiable {
    let id: Int
    let title: String
    let isCompleted: Bool
    let imagePath: String?
    let createdAt: Date
    let completedAt: Date?
}
