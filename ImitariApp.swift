//
//  ImitariApp.swift
//  Imitari
//
//  Created by david norminton on 18/11/2023.
//

import SwiftUI
import PhotosUI
import Foundation

@main
struct ImitariApp: App {
    
    @State private var importing = false
    @State private var currentFile = ""
    @State private var currentDirectory = "/"
    @State private var zoom = 1.00
    @State private var currentFileNumber = 0
    @State private var totalFiles = 0
    @State private var aspectRatio = "fit"
    @State private var allFiles = [String]()
    @State private var showSlideShow = false
    @State private var showSettings = false
    @State private var slideShowInterval = 3
    @State private var isVertFlipped = false
    @State private var isHorzFlipped = false
    
    // EnviromentObject states
    @StateObject var slideShowState = SlideShowState()


    var diretoryPath = DirectoryPath()
    var filesInDir = FilesInDirectory()
    
    @State private var windowCount = 1

    var body: some Scene {

        WindowGroup {
            GeometryReader { proxy in
                ContentView(
                    currentFile: $currentFile,
                    currentDirectory: $currentDirectory,
                    zoom: $zoom,
                    currentFileNumber: $currentFileNumber,
                    totalFiles: $totalFiles,
                    aspectRatio: $aspectRatio,
                    allFiles: $allFiles,
                    isVertFlipped: $isVertFlipped,
                    isHorzFlipped: $isHorzFlipped
                )
                .environmentObject(slideShowState)
                .onOpenURL(perform: { url in
                    Logger.shared.log("open url.")
                    Logger.shared.log(url.absoluteString)
                    Logger.shared.log(url.relativePath)
                    Logger.shared.log(url.path())

                    if (diretoryPath.isPathFile(path: url.path())) {
                        let chosenDirectory = diretoryPath.getDirectoryOfImage(image: url.path())
                        currentDirectory = chosenDirectory

                        if let currentFilePos = filesInDir.currentFile(
                            current: url.absoluteString,
                            dir: currentDirectory,
                            type: "current"
                        ) {
                            currentFile = currentFilePos.path
                            currentFileNumber = currentFilePos.position
                            totalFiles = currentFilePos.totalFiles
                            allFiles = currentFilePos.allFilesInDir
                        }
                    }
                })
            }
        }
        .commands {
            CommandGroup(before: CommandGroupPlacement.newItem) {
                Button("Open image or directory") {
                    importing = true
                    isVertFlipped = false
                    isHorzFlipped = false
                }
                .fileImporter(
                    isPresented: $importing,
                    allowedContentTypes: [.png, .jpeg, .gif, .directory]
                ) { result in
                    print("Loading file")
                    switch result {
                    case .success(let file):
                        let filePath: String = file.path()
                        print(file)

                        if (diretoryPath.isPathFile(path: filePath)) {
                            let chosenDirectory = diretoryPath.getDirectoryOfImage(image: filePath)
                            currentDirectory = chosenDirectory
 
                            if let currentFilePos = filesInDir.currentFile(current: filePath, dir: currentDirectory, type: "current") {
                                currentFile = currentFilePos.path
                                currentFileNumber = currentFilePos.position
                                totalFiles = currentFilePos.totalFiles
                                allFiles = currentFilePos.allFilesInDir
                            }
                        } else {
                            let firstImage = diretoryPath.getFirstFile(directory: filePath) ?? ""
                            currentDirectory = filePath
                            
                            if (firstImage.count > 0) {
                                if let firstFile = filesInDir.firstFile(dir: currentDirectory) {
                                    currentFile = firstFile.path
                                    currentFileNumber = firstFile.position
                                    totalFiles = firstFile.totalFiles
                                    allFiles = firstFile.allFilesInDir
                                }
                            }
                        }
                        file.stopAccessingSecurityScopedResource()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }

            }
            CommandMenu("Tools") {
                
                Navigate(
                    allFiles: $allFiles,
                    currentFileNumber: $currentFileNumber,
                    currentFile: $currentFile,
                    currentDirectory: $currentDirectory
                )
                
                SlideShowCmd().environmentObject(slideShowState)
                
                ZoomCmdsGroup(zoom: $zoom)
                
                ScaleContent(aspectRatio: $aspectRatio)
                
                Button("Rotate left") {
                    
                }
                Button("Rotate right") {
                    
                }
                
                Button("Flip vertical") {
                    // flip vertical
                    if isVertFlipped {
                        isVertFlipped = false
                    } else {
                        isVertFlipped = true
                    }
                }
                
                Button("Flip horizonatal") {
                    // flip horizontal
                    if isHorzFlipped {
                        isHorzFlipped = false
                    } else {
                        isHorzFlipped = true
                    }
                }
            }
        }
    }
}

