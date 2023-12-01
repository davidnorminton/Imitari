import SwiftUI


extension Image {
    func slideShowImageProps(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .position(x: width / 2, y: height / 2)
    }
}


struct SlideShow: View {
    @State private var currentIndex = 0
    @State private var path = ""
    @Binding var allFiles: [String]
    @Binding var currentDirectory: String
    @Binding var currentFile: String
    @Binding var currentFileNumber: Int
    @Binding var aspectRatio: String
    @State var counter = 1
    
    @EnvironmentObject var slideShowState:  SlideShowState

    var dirPath = DirectoryPath()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var currentImage: NSImage?
    
    var body: some View {
        NavigationStack {
            Text("")
                .navigationTitle(dirPath.getFileNameFromPath(path: currentFile))
        }
        
        VStack {
            if let image = currentImage {
                
                HStack {
                    GeometryReader { geometry in
                        switch (aspectRatio) {
                        case "fit":
                            Image(nsImage: image)
                                .slideShowImageProps(width: geometry.size.width, height: geometry.size.height)
                                .aspectRatio(contentMode: .fit)

                        case "fill":
                            Image(nsImage: image)
                                .slideShowImageProps(width: geometry.size.width, height: geometry.size.height)
                                .aspectRatio(contentMode: .fill)
                        default:
                            Image(nsImage: image)
                                .slideShowImageProps(width: geometry.size.width, height: geometry.size.height)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .clipped()
            }
        }
        
        .onReceive(timer) { _ in
            if counter == slideShowState.slideShowInterval {
                currentIndex = (currentIndex + 1) % allFiles.count
                loadNextImage()
                counter = 1
            } else {
                counter += 1
            }
        }
        .onAppear {
            loadNextImage()
        }
        .onTapGesture {
            slideShowState.showSlideShow = false
        }
    }
    
    private func loadNextImage() {
        let file = allFiles[currentIndex]
        currentFile = currentDirectory + "/" + file
        currentFileNumber = currentIndex + 1
        
        let imageURL = URL(fileURLWithPath: currentFile).absoluteURL
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            // Use this on main image to get image properties
            guard let data = data, let image = NSImage(data: data) else { return }
//            print(image.size.width)
//            print(image.size.height )
            DispatchQueue.main.async { [self] in
                currentImage = image
            }
        }.resume()
    }
}
