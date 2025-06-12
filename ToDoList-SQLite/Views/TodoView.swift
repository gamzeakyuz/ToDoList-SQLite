//
//  TodoView.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 10.05.2025.
//

import SwiftUI

struct TodoView: View {
    
    @EnvironmentObject var todoViewModel: ToDoViewModel
    @State private var taskTitle: String = ""
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
//    @State private var isAddTaskPresented = false

    var body: some View {
        ZStack {
            if todoViewModel.tasks.isEmpty {
                VStack(spacing: 10) {
                    
                    Text("Hiçbir görev yok!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .shadow(color: Color(#colorLiteral(red: 0.8803732991, green: 0.903868854, blue: 0.0486465469, alpha: 1)), radius: 25)
                    
                    Text("Üretken bir insan mısınız? Bence ekle butonuna tıklayıp yapılacaklar listenize bir sürü madde eklemelisiniz!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                        .shadow(color: Color(#colorLiteral(red: 0.8803732991, green: 0.903868854, blue: 0.0486465469, alpha: 1)), radius: 25)
                    
                    
                }
                .frame(maxWidth: 400)
                .multilineTextAlignment(.center)
                .padding(50)
            } else {
                List {
                    ForEach(todoViewModel.tasks) { task in
                        HStack {
                            // Görev Görseli
                            if let path = task.imagePath,
                               let image = ImageHelper.loadImage(path: path) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                Image(systemName: "photo")
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            // Görev Bilgisi
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.headline)
                                    .strikethrough(task.isCompleted, color: .gray)
                                Text(task.isCompleted ? "Tamamlandı" : "Tamamlanmadı")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                // Eklenme tarihi
                                Text("Eklenme: \(formatterDate(task.createdAt))")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                
                                // Tamamlanma tarihi varsa göster
                                if let completedAt = task.completedAt {
                                    Text("Tamamlanma: \(formatterDate(completedAt))")
                                        .font(.caption2)
                                        .foregroundColor(.green)
                                }
                            }
                            
                            Spacer()
                            
                            // Tamamlandı simgesi
                            Button(action: {
                                withAnimation {
                                    todoViewModel.updateTask(task)
                                }
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: todoViewModel.deleteTask)
                    .onMove(perform: todoViewModel.moveTask)
                }
                .listStyle(InsetGroupedListStyle())
                
            }
        }
        .navigationTitle("My List")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: EditButton(),trailing: NavigationLink(destination: AddTask()) { Image(systemName: "text.badge.plus") })
        .sheet(isPresented: $showingImagePicker) { ImagePicker(selectedImage: $selectedImage) }
    }
    
   
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
            .environmentObject(ToDoViewModel())
    }
}
