//
//  SQLiteCommands.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 9.05.2025.
//

import Foundation
import SQLite
import SwiftUI
import SQLite3

struct SQLiteCommands {
    
    static var table = Table("todo")
    
    static let id = SQLite.Expression<Int>("id")
    static let title = SQLite.Expression<String>("title")
    static let isCompleted = SQLite.Expression<Bool>("isCompleted")
    static let imagePath = SQLite.Expression<String?>("imagePath")
    static let createdAt = SQLite.Expression<Date>("createdAt")
    static let completedAt = SQLite.Expression<Date?>("completedAt")

    
    static func createTable(){
        
        guard let database = SQLiteDatabase.shared.db else {
            print("Data connection Error")
            return
        }
        
        do {
            
            try database.run(table.create(ifNotExists: true) { tab in
                
                tab.column(id, primaryKey: true)
                tab.column(title)
                tab.column(isCompleted)
                tab.column(imagePath)
                tab.column(createdAt)
                tab.column(completedAt)
                
            })
            
            print("Table created")
            
        }catch {
            print("Table creation error: \(error)")
        }
        
    }
    
    static func insertRow(_ todoValues: TaskModel) -> Bool? {
        
        guard let database = SQLiteDatabase.shared.db else {
            print("Data connection Error")
            return nil
        }
        
        do {
            try database.run(
                table.insert(
                    title <- todoValues.title,
                    isCompleted <- todoValues.isCompleted,
                    imagePath <- todoValues.imagePath,
                    createdAt <- todoValues.createdAt,
                    completedAt <- todoValues.completedAt
                )
            )
            
            print("Data added")
            
            return true
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message) in \(String(describing: statement))")
            return false
        }catch let error {
            print("Insert failed:\(error)")
            return false
        }
        
    }
    
    static func listRow() -> [TaskModel] {
        
        guard let database = SQLiteDatabase.shared.db else {
            print("Data connection error")
            return []
        }
        
        var todoArray = [TaskModel]()
        
        let todoTable = table.order(id.desc)
        
        do {

            for todo in try database.prepare(todoTable) {
                
                let idValue = todo[id]
                let titleValue = todo[title]
                let isCompletedValue = todo[isCompleted]
                let imagePathValue = todo[imagePath]
                let createdAtValue = todo[createdAt]
                let completedAtValue = todo[completedAt]
                
                let todoObject = TaskModel(id: idValue, title: titleValue, isCompleted: isCompletedValue, imagePath: imagePathValue, createdAt: createdAtValue, completedAt: completedAtValue)
                
                todoArray.append(todoObject)
                
                print("Data read")
                
            }
        }catch {
            print("Data reading error: \(error)")
        }
        return todoArray
    }
    
    static func updateRow(_ task: TaskModel) {
        guard let db = SQLiteDatabase.shared.db else { return }

        let item = table.filter(id == task.id)
        do {
            try db.run(item.update(
                isCompleted <- task.isCompleted,
                completedAt <- task.completedAt)
            )
            print("Data updated")
        } catch {
            print("Updating Error: \(error)")
        }
    }
    static func deleteRow(_ taskId: Int) {
            guard let db = SQLiteDatabase.shared.db else { return }

            let item = table.filter(id == taskId)
            do {
                try db.run(item.delete())
                print("Data deleted")
            } catch {
                print("Deleting Error: \(error)")
            }
        }
    
}
