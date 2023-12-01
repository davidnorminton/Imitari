//
//  CurrentAppState.swift
//  Imitari
//
//  Created by david norminton on 01/12/2023.
//

import Foundation
import SwiftUI

final class CurrentAppState: ObservableObject {
    
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
    
    var diretoryPath = DirectoryPath()
    var filesInDir = FilesInDirectory()

    /**
     * Goto next file in list
     */
    func nextFile() {
        if self.allFiles.count > 0 {
            let fileCount = self.allFiles.count

            if self.currentFileNumber == 1 {
                self.currentFile = self.currentDirectory + "/" + self.allFiles[fileCount - 1]
                self.currentFileNumber = fileCount
            } else {
                self.currentFile = self.currentDirectory + "/" + self.allFiles[self.currentFileNumber - 2]
                self.currentFileNumber -= 1
            }
        }
    }
    
    /**
     * Goto previous file in list
     */
    func previousFile() {
        if (self.allFiles.count > 0) {
            if (self.currentFileNumber == self.allFiles.count) {
                self.currentFile = self.currentDirectory + "/" + self.allFiles[0]
                self.currentFileNumber = 1
            } else {
                self.currentFile = self.currentDirectory + "/" + self.allFiles[self.currentFileNumber]
                self.currentFileNumber += 1
            }
        }
    }
    
    func setCurrentState(path: String) {
        if (diretoryPath.isPathFile(path: path)) {
            setCurrentByChoice(path: path)
        } else {
            setCurrentByFirstInDirectory(path: path)
        }
    }
    
    func setCurrentByChoice(path: String) {
        let chosenDirectory = diretoryPath.getDirectoryOfImage(image: path)
        self.currentDirectory = chosenDirectory

        if let currentFilePos = filesInDir.currentFile(
            current: path,
            dir: self.currentDirectory,
            type: "current"
        ) {
            self.currentFile = currentFilePos.path
            self.currentFileNumber = currentFilePos.position
            self.totalFiles = currentFilePos.totalFiles
            self.allFiles = currentFilePos.allFilesInDir
        }
    }
    
    func setCurrentByFirstInDirectory(path: String) {
        let firstImage = diretoryPath.getFirstFile(directory: path) ?? ""
        self.currentDirectory = path
        
        if (firstImage.count > 0) {
            if let firstFile = filesInDir.firstFile(dir: self.currentDirectory) {
                self.currentFile = firstFile.path
                self.currentFileNumber = firstFile.position
                self.totalFiles = firstFile.totalFiles
                self.allFiles = firstFile.allFilesInDir
            }
        }
    }
}

