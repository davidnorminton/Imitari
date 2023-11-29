//
//  NextPreviousFile.swift
//  Imitari
//
//  Created by david norminton on 19/11/2023.
//

import Foundation

struct FileDirectoryPosition {
    var path: String = ""
    var position: Int = 0
    var totalFiles: Int = 0
    var allFilesInDir = [String]()
}

class FilesInDirectory {
    var diretoryPath = DirectoryPath()
    var currentFile = FileDirectoryPosition()

    
    func currentFile(current: String, dir: String, type: String?) -> FileDirectoryPosition? {
        let currentFileName = diretoryPath.getFileNameFromPath(path: current)
        if let allFiles = diretoryPath.getFilesInDir(dir: dir) {
            let fileCount = allFiles.count
            currentFile.totalFiles = fileCount
            var counter: Int = 0

            for file in allFiles {
                if (file == currentFileName.removingPercentEncoding) {
                    currentFile.position = counter + 1
                    currentFile.path = dir + "/" + allFiles[counter]
                    currentFile.allFilesInDir = allFiles
                    return currentFile
                }

                counter += 1
            }
        }
        
        return nil
    }
    
    func firstFile(dir: String) -> FileDirectoryPosition? {
        if let allFiles = diretoryPath.getFilesInDir(dir: dir) {
            currentFile.totalFiles = allFiles.count
            currentFile.position = 1
            currentFile.path = dir + "/" + allFiles[0]
            currentFile.allFilesInDir = allFiles
            return currentFile
        }
        
        return nil
    }
}
