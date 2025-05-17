//
//  AddTask.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 10.05.2025.
//

import SwiftUI

struct AddTask: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var todoViewModel: ToDoViewModel
    
    @State private var textfieldText: String = ""
    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false
    
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                
//                Text("Add a Task")
//                    .font(.title) 
//                    .fontWeight(.heavy)
//                
                HStack {
                    TextField("Task Title", text: $textfieldText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Image(systemName: "photo.stack.fill")
                            .imageScale(.large)
                            .foregroundColor(.accent)
                    }
                }
                .padding(.horizontal)
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                        .border(.black)
                        .cornerRadius(20)
                }
                
                Button("Save") {
                    if textIsAppropriate() {
                        var imagePath: String?
                        if let image = selectedImage {
                            imagePath = ImageHelper.saveImage(image)
                        }
                        todoViewModel.addTask(title: textfieldText, imagePath: imagePath)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.accent)
                .foregroundColor(.white)
                .cornerRadius(12)
                .font(.subheadline)
                .fontWeight(.heavy)
                .padding(.horizontal)
                
            }
            .padding(.top)
        }
        .navigationTitle("Add a task")
        .alert(isPresented: $showAlert, content: getAlert)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
    func textIsAppropriate() -> Bool {
        if textfieldText.count < 5 {
            alertTitle = "Task title must be at least 5 characters!"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        Alert(title: Text(alertTitle))
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTask()
        }
        .environmentObject(ToDoViewModel())
        .foregroundColor(.gray)
    }
}

