//
//  LocalFileManager.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 6/1/22.
//

import Foundation
import SwiftUI


class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage,imageName: String, FolderName: String) {
        
        // create folder
        createFolder(FolderName: FolderName)
        
        // get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, FolderName: FolderName)
        else { return }
        
        // save image to path
        do {
            try  data.write(to: url)
        } catch let error {
            print("Error saving image. ImageName: \(imageName) . \(error)")
        }
    }
    
    func getImage(imageName: String, FolderName: String) -> UIImage? {
        
         guard let url = getURLForImage(imageName: imageName, FolderName: FolderName),
               FileManager.default.fileExists(atPath: url.path) else {
                   return nil
               }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolder(FolderName: String ) {
        guard let url = getURLFolder(Foldername: FolderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error Creating Directory. FolderName: \(FolderName). \(error)")
            }
        }
    }
    
    private func getURLFolder(Foldername: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return  nil
        }
        return url.appendingPathComponent(Foldername)
    }
    
    private func getURLForImage(imageName: String, FolderName: String) -> URL? {
        guard let folderURL = getURLFolder(Foldername: FolderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
}
