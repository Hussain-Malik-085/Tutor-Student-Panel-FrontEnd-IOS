import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreen()
                    .onAppear {
                        // 5 seconds baad splash hide
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            }
            else {
                NavigationStack {
                    CreateProfileDescription()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
