import SwiftUI


struct MainImageView: View {

    @EnvironmentObject var currentAppState:  CurrentAppState
    
    @State private var appHeight:CGFloat = CGFloat()
    @State private var appWidth:CGFloat = CGFloat()

    var dirPath = DirectoryPath()
    
    var body: some View {

        AnyView(
            GeometryReader { geometry in
                ScrollView([.horizontal, .vertical], showsIndicators: true) {

                    MainImage()
                        .environmentObject(currentAppState)
                        .onAppear {
                            currentAppState.appHeight = geometry.size.height
                            currentAppState.appWidth = geometry.size.width
                        }
                }
            }
            .navigationTitle(dirPath.getFileNameFromPath(path: currentAppState.currentFile))
        )
    }
}

