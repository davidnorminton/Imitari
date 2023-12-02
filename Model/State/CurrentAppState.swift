//
//  CurrentAppState.swift
//  Imitari
//
//  Created by david norminton on 01/12/2023.
//

import Foundation
import SwiftUI

final class CurrentAppState: ObservableObject {
    
    @Published var cgUrl: URL? = nil
    @Published var currentFile: String = ""
    @Published var currentDirectory: String = ""
    @Published var currentFileNumber: Int = 1
    @Published var allFiles = [String]()
    @Published var totalFiles: Int = 1
    @Published var zoom: Double = 1.00
    @Published var aspectRatio = "fit"
    @Published var isVertFlipped = false
    @Published var isHorzFlipped = false
    @Published var showMenu = false
    @Published var appHeight = CGFloat()
    @Published var appWidth = CGFloat()
    
    var diretoryPath = DirectoryPath()
    var filesInDir = FilesInDirectory()

    
    func setCurrentFileUrl() {
        // Safely unwrap the optional file path
        guard let decodedFilePath = currentFile.removingPercentEncoding else {
            print("Unable to decode file path")
            return
        }
        
        // Create URL using the decoded file path
        let fileURL = URL(fileURLWithPath: decodedFilePath)

        // Check if the file URL is a file URL and if it actually exists
        if fileURL.isFileURL && FileManager.default.fileExists(atPath: fileURL.path) {
            cgUrl = fileURL
        } else {
            print("Invalid file path or file does not exist: \(fileURL)")
        }
    }
    /**
     * Goto next file in list
     */
    func previousFile() {
        if allFiles.count > 0 {

            let fileCount = allFiles.count

            if currentFileNumber == 1 {
                currentFile = currentDirectory + "/" + allFiles[fileCount - 1]
                currentFileNumber = fileCount
            } else {
                currentFile = currentDirectory + "/" + allFiles[currentFileNumber - 2]
                currentFileNumber -= 1
            }
            
            setCurrentFileUrl()
        }
    }
    
    /**
     * Goto previous file in list
     */
    func nextFile() {
        if (self.allFiles.count > 0) {

            if (self.currentFileNumber == self.allFiles.count) {
                self.currentFile = self.currentDirectory + "/" + self.allFiles[0]
                self.currentFileNumber = 1
            } else {
                self.currentFile = self.currentDirectory + "/" + self.allFiles[self.currentFileNumber]
                self.currentFileNumber += 1
            }
            
            setCurrentFileUrl()
        }
    }
    
    func setCurrentState(path: String, file: URL) {
        if (diretoryPath.isPathFile(path: path)) {
            setCurrentByChoice(path: path, file: file)
        } else {
            setCurrentByFirstInDirectory(path: path, file: file)
        }
    }
    
    func setCurrentByChoice(path: String, file: URL) {
        let chosenDirectory = diretoryPath.getDirectoryOfImage(image: path)
        self.currentDirectory = chosenDirectory
        self.cgUrl = file
        
        if let currentFilePos = filesInDir.currentFile(
            current: path,
            dir: self.currentDirectory,
            type: "current"
        ) {
            self.currentFile = currentFilePos.path
            self.currentFileNumber = currentFilePos.position
            self.totalFiles = currentFilePos.totalFiles
            self.allFiles = currentFilePos.allFilesInDir
            self.cgUrl = file
        }
    }
    
    func setCurrentByFirstInDirectory(path: String, file: URL) {
        let firstImage = diretoryPath.getFirstFile(directory: path) ?? ""
        self.currentDirectory = path
        
        if (firstImage.count > 0) {
            if let firstFile = filesInDir.firstFile(dir: self.currentDirectory) {
                self.currentFile = firstFile.path
                self.currentFileNumber = firstFile.position
                self.totalFiles = firstFile.totalFiles
                self.allFiles = firstFile.allFilesInDir
                if let path = self.currentFile.removingPercentEncoding {
                    self.cgUrl = URL(fileURLWithPath: path)
                }
            }
        }
    }
    
    // flip vertical
    func flipVertical() {
        if self.isVertFlipped {
            self.isVertFlipped = false
        } else {
            self.isVertFlipped = true
        }
    }
    
    // flip horizontal
    func flipHorizontal() {
        if self.isHorzFlipped {
            self.isHorzFlipped = false
        } else {
            self.isHorzFlipped = true
        }
    }
    
    func rotateLeft() {
        
    }
    
    func rotateRight() {
        
    }
}

