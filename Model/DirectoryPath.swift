//
//  DirectoryPath.swift
//  Imitari
//
//  Created by david norminton on 19/11/2023.
//

import Foundation




class DirectoryPath {
    /**
     * File types the application can handle
     */
    let allowedTypes = ["jpg", "png", "jpeg", "gif"]

    /**
     * Get  path with  file removed
     */
    func getDirectoryOfImage(image: String) -> String {
        var pathParts: Array = image.components(separatedBy: "/")
        pathParts.removeLast()
        return pathParts.joined(separator: "/")
    }
    
    /**
     * Extract filename from file path
     */
    func getFileNameFromPath(path: String) -> String {
        var pathParts: Array = path.components(separatedBy: "/")
        return pathParts.removeLast()
    }

    /**
     * Check if path is to a file
     */
    func isPathFile(path: String) -> Bool {
        var pathParts: Array = path.components(separatedBy: "/")
        let lastPart = pathParts.removeLast()
        if (lastPart.contains(".")) {
            return true
        }
        
        return false
    }
    
    /**
     * Get first image file in directory
     */
    func getFirstFile(directory: String) -> String? {
        do {
            let path = directory.replacingOccurrences(of: "%20", with: " ")

            let items = try FileManager.default.contentsOfDirectory(atPath: path)
            for item in items {
                for type in allowedTypes {
                    if (item.hasSuffix(type)) {
                        return String(directory + item).removingPercentEncoding
                    }
                }
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
            return nil
        }
        
        return nil
    }
    
    /**
     * Get all allowed files in a directory
     */
    func getFilesInDir(dir: String) -> Array<String>? {
        do {
            var images = [String]()
            let items = try FileManager.default.contentsOfDirectory(atPath: dir.removingPercentEncoding ?? dir)

            for item in items {
                for type in allowedTypes {
                    if (item.hasSuffix(type)) {
                        images.append(item)
                    }
                }
            }
            return images
        } catch {
            // failed to read directory – bad permissions, perhaps?
            return nil
        }        
    }
}
