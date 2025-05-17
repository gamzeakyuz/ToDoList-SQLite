//
//  ImageHelper.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 10.05.2025.
//

import Foundation
import UIKit

struct ImageHelper {
    
    static func saveImage(_ image: UIImage) -> String?{
        
        guard let data = image.jpegData(compressionQuality: 0.8)
        else {
            return nil
        }
        
        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)

        do {
            try data.write(to: url)
            return filename
        } catch {
            print("Resim kaydedilemedi:", error)
            return nil
        }
    }

    static func loadImage(path: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(path)
        return UIImage(contentsOfFile: url.path)
    }

    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
}
