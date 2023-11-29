import SwiftUI


struct MainImage: View {
    @Binding var currentFile: String
    @Binding var zoom: Double
    @Binding var aspectRatio: String
    @Binding var isVertFlipped: Bool
    @Binding var isHorzFlipped: Bool

    var dirPath = DirectoryPath()
    var imageSaver = ImageSaver()
    
    var body: some View {
        let file = currentFile.removingPercentEncoding
        let url = URL(fileURLWithPath: file ?? currentFile)
        
        if let imageData = try? Data(contentsOf: url),
           let nsImage = NSImage(data: imageData) {
            return AnyView(
                GeometryReader { geometry in
                    ScrollView([.horizontal, .vertical], showsIndicators: true) {
                        let image = Image(nsImage: nsImage)
                            .resizable()
                            .scaledToFill()
                            .scaleEffect(x: isHorzFlipped ? -1 : 1, y: isVertFlipped ? -1 : 1)

                        switch aspectRatio {
                        case "fit":
                            image.frame(height: CGFloat(geometry.size.height) * CGFloat(zoom))
                        case "fill":
                            image.frame(width: CGFloat(geometry.size.width) * CGFloat(zoom))
                        default:
                            image.frame(height: CGFloat(geometry.size.height) * CGFloat(zoom))
                        }
                    }
                }
                .navigationTitle(dirPath.getFileNameFromPath(path: currentFile))
            )
        } else {
            return AnyView(Text("Unable to open file: \(currentFile)"))
        }
    }

}

