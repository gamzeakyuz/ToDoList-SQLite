//
//  SQLiteDatabase.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 9.05.2025.
//

import Foundation
import SQLite

class SQLiteDatabase {
    
    static let shared = SQLiteDatabase()
    var db: Connection?
    
    private init() {
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("todoList").appendingPathExtension("sqlite3")
            
            db = try Connection(fileUrl.path())
        }catch {
            print("Connection to database Error: \(error)")
        }
        
    }
    func createTable() {
        SQLiteCommands.createTable()
    }
    
}
