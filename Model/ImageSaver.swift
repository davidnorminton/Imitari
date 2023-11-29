//
//  ImageSaver.swift
//  Imitari
//
//  Created by david norminton on 25/11/2023.
//

import Foundation
import SwiftUI
import AppKit

class ImageSaver {
    func saveImageToDocumentDirectory(nsImage: NSImage, filePath: String) {
        let fileURL = URL(fileURLWithPath: filePath)
        let directoryURL = fileURL.deletingLastPathComponent()
        let fileName = fileURL.lastPathComponent

        guard let imageType = getImageType(filePath: filePath) else {
            print("Unsupported file type")
            return
        }

        let savedFileURL = directoryURL.appendingPathComponent("\(fileName)")

        guard let imageData = getImageData(nsImage: nsImage, ofType: imageType) else {
            print("Failed to get image data")
            return
        }

        do {
            try imageData.write(to: savedFileURL)
            print("Image saved as \(imageType.rawValue) to: \(savedFileURL)")
        } catch {
            print("Error saving image:", error)
        }
    }

    func getImageType(filePath: String) -> ImageType? {
        let fileExtension = URL(fileURLWithPath: filePath).pathExtension.lowercased()

        switch fileExtension {
        case "jpg", "jpeg":
            return .jpeg
        case "png":
            return .png
        default:
            return nil
        }
    }

    func getImageData(nsImage: NSImage, ofType imageType: ImageType) -> Data? {
        switch imageType {
        case .jpeg:
            return nsImageToJPEGData(nsImage: nsImage)
        case .png:
            return nsImageToPNGData(nsImage: nsImage)
        }
    }

    func nsImageToJPEGData(nsImage: NSImage) -> Data? {
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            print("Failed to get CGImage from NSImage")
            return nil
        }

        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        return bitmapRep.representation(using: .jpeg, properties: [:])
    }

    func nsImageToPNGData(nsImage: NSImage) -> Data? {
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            print("Failed to get CGImage from NSImage")
            return nil
        }

        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        return bitmapRep.representation(using: .png, properties: [:])
    }
}

enum ImageType: String {
    case jpeg = "JPEG"
    case png = "PNG"
}
