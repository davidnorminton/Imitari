import SwiftUI


struct MainImage: View {

    @EnvironmentObject var currentAppState:  CurrentAppState

    var dirPath = DirectoryPath()
    var imageSaver = ImageSaver()
    
    var body: some View {
        let file = currentAppState.currentFile.removingPercentEncoding
        let url = URL(fileURLWithPath: file ?? currentAppState.currentFile.replacingOccurrences(of: "%20", with: " "))
        
        if let imageData = try? Data(contentsOf: url),
           let nsImage = NSImage(data: imageData) {
            return AnyView(
                GeometryReader { geometry in
                    ScrollView([.horizontal, .vertical], showsIndicators: true) {
                        let image = Image(nsImage: nsImage)
                            .resizable()
                            .scaledToFill()
                            .scaleEffect(
                                x: currentAppState.isHorzFlipped ? -1 : 1,
                                y: currentAppState.isVertFlipped ? -1 : 1
                            )

                        switch currentAppState.aspectRatio {
                        case "fit":
                            image.frame(height: CGFloat(geometry.size.height) * CGFloat(currentAppState.zoom))
                        case "fill":
                            image.frame(width: CGFloat(geometry.size.width) * CGFloat(currentAppState.zoom))
                        default:
                            image.frame(height: CGFloat(geometry.size.height) * CGFloat(currentAppState.zoom))
                        }
                    }
                }
                    .navigationTitle(dirPath.getFileNameFromPath(path: currentAppState.currentFile))
            )
        } else {
            return AnyView(Text("Unable to open file: \(currentAppState.currentFile)"))
        }
    }

}

