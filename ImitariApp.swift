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

    
    // EnviromentObject states
    @StateObject var currentAppState = CurrentAppState()
    @StateObject var slideShowState = SlideShowState()


    var diretoryPath = DirectoryPath()
    var filesInDir = FilesInDirectory()
    
    @State private var windowCount = 1

    var body: some Scene {

        WindowGroup {
            GeometryReader { proxy in
                ContentView()
                .environmentObject(currentAppState)
                .environmentObject(slideShowState)
                .onOpenURL(perform: { url in
                    Logger.shared.log("open url.")
                    Logger.shared.log(url.absoluteString)
                    Logger.shared.log(url.relativePath)
                    Logger.shared.log(url.path())

                    if (diretoryPath.isPathFile(path: url.path())) {
                        let chosenDirectory = diretoryPath.getDirectoryOfImage(image: url.path())
                        currentAppState.currentDirectory = chosenDirectory

                        if let currentFilePos = filesInDir.currentFile(
                            current: url.absoluteString,
                            dir: currentAppState.currentDirectory,
                            type: "current"
                        ) {
                            currentAppState.currentFile = currentFilePos.path
                            currentAppState.currentFileNumber = currentFilePos.position
                            currentAppState.totalFiles = currentFilePos.totalFiles
                            currentAppState.allFiles = currentFilePos.allFilesInDir
                        }
                    }
                })
            }
        }
        .commands {
            CommandGroup(before: CommandGroupPlacement.newItem) {
                Button("Open image or directory") {
                    importing = true
                    currentAppState.isVertFlipped = false
                    currentAppState.isHorzFlipped = false
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
                            currentAppState.currentDirectory = chosenDirectory
 
                            if let currentFilePos = filesInDir.currentFile(
                                current: filePath,
                                dir: currentAppState.currentDirectory,
                                type: "current"
                            ) {
                                currentAppState.currentFile = currentFilePos.path
                                currentAppState.currentFileNumber = currentFilePos.position
                                currentAppState.totalFiles = currentFilePos.totalFiles
                                currentAppState.allFiles = currentFilePos.allFilesInDir
                            }
                        } else {
                            let firstImage = diretoryPath.getFirstFile(directory: filePath) ?? ""
                            currentAppState.currentDirectory = filePath
                            
                            if (firstImage.count > 0) {
                                if let firstFile = filesInDir.firstFile(dir: currentAppState.currentDirectory) {
                                    currentAppState.currentFile = firstFile.path
                                    currentAppState.currentFileNumber = firstFile.position
                                    currentAppState.totalFiles = firstFile.totalFiles
                                    currentAppState.allFiles = firstFile.allFilesInDir
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
                
                Navigate().environmentObject(currentAppState)

                
                SlideShowCmd().environmentObject(slideShowState)
                
                ZoomCmdsGroup().environmentObject(currentAppState)

                
                ScaleContent().environmentObject(currentAppState)

                
                Button("Rotate left") {
                    
                }
                Button("Rotate right") {
                    
                }
                
                Button("Flip vertical") {
                    // flip vertical
                    if currentAppState.isVertFlipped {
                        currentAppState.isVertFlipped = false
                    } else {
                        currentAppState.isVertFlipped = true
                    }
                }
                
                Button("Flip horizonatal") {
                    // flip horizontal
                    if currentAppState.isHorzFlipped {
                        currentAppState.isHorzFlipped = false
                    } else {
                        currentAppState.isHorzFlipped = true
                    }
                }
            }
        }
    }
}

