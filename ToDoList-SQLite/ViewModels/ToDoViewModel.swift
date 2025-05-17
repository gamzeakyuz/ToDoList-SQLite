//
//  ToDoViewModel.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 10.05.2025.
//

import Foundation
import SQLite

@MainActor
class ToDoViewModel: ObservableObject {
    
    @Published var tasks: [TaskModel] = []

    
    init() {
        SQLiteCommands.createTable()
        loadTasks()
    }
    func loadTasks(){
        Task {
            self.tasks = await fetchTasksAsync()
        }
    }
    private func fetchTasksAsync() async -> [TaskModel] {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .background).async {
                let result = SQLiteCommands.listRow()
                continuation.resume(returning: result)
            }
        }
    }
    func moveTask(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
    }
    func addTask(title: String, imagePath: String? = nil) {
        Task {
            let task = TaskModel(id: 0,
                                 title: title,
                                 isCompleted: false,
                                 imagePath: imagePath,
                                 createdAt: Date(),
                                 completedAt: nil)
            await performInBackground {
                SQLiteCommands.insertRow(task)
            }
            loadTasks()
        }
    }
    func updateTask(_ task: TaskModel) {
        Task {
            let updatedTask = TaskModel(
                id: task.id,
                title: task.title,
                isCompleted: !task.isCompleted,
                imagePath: task.imagePath,
                createdAt: task.createdAt,
                completedAt: task.isCompleted ? nil : Date()
            )
            await performInBackground {
                SQLiteCommands.updateRow(updatedTask)
            }
            loadTasks()
        }
    }
    func deleteTask(indexSet: IndexSet) {
        Task {
            await performInBackground {
                indexSet.forEach { index in
                    SQLiteCommands.deleteRow(self.tasks[index].id)
                }
            }
            loadTasks()
        }
    }
    private func performInBackground(_ action: @escaping () -> Void) async {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .background).async {
                action()
                continuation.resume()
            }
        }
    }
}
