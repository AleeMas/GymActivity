import SwiftUI
import Foundation

struct VisuWOView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var gymTabController: GymTabController
    
    @State var tabIndex: Int
    @State var cover:Bool=false
    @State private var currentPage = 0
    
    

    var body: some View {
    
                VisuEX(
                    presentationModeRoot: presentationMode,
                    gymTabController:gymTabController,
                    cover: cover,
                    tabIndex: tabIndex
                )
    }
}

/* var body: some View {
 
 Button(action: {
     cover = true
 }) {
     Text("Start Workout")
         .font(.largeTitle)
         .foregroundColor(.white)
         .padding()
         .background(Color.green)
         .cornerRadius(10)
 }.fullScreenCover(isPresented: $cover) {
     VisuEX(
         presentationModeRoot: presentationMode,
         gymTabController:gymTabController,
         cover: cover,
         tabIndex: tabIndex
     )
 }
}
}*/
