//
//  TaskRowView.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 10.05.2025.
//

import SwiftUI

struct TaskRowView: View {
    
    let taskRow: TaskModel

    var body: some View {
        HStack(spacing: 15) {
            if let path = taskRow.imagePath,
               let uiImage = ImageHelper.loadImage(path: path) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(taskRow.title)
                    .font(.headline)
                    .strikethrough(taskRow.isCompleted, color: .gray)
                    .foregroundColor(taskRow.isCompleted ? .gray : .primary)
                
                Text("Eklenme: \(taskRow.createdAt.formatted(.dateTime.day().month().year().hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                Text("Tamamlanma: \(taskRow.completedAt?.formatted(.dateTime.day().month().year().hour().minute()) ?? "-")")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: taskRow.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(taskRow.isCompleted ? .green : .gray)
        }
        .padding(.vertical, 5)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    
    static var task1 = TaskModel(id: 1, title: "Bu benim ilk görevim", isCompleted: true, imagePath: "photo", createdAt: Date.now, completedAt: nil)
    
    static var previews: some View {
        TaskRowView(taskRow: task1)
            .previewLayout(.sizeThatFits)
    }
    
}
