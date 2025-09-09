import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                Image(systemName: "bolt.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                Text("Welcome to MyApp")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        
    }
}
//
#Preview {
    SplashScreen()
}

//  Splash.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/08/2025.
//

