//
//  Navigations.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/09/2025.
//

import SwiftUI

struct Navigations: View {
    @State private var isDrawerOpen = false
    var body: some View {
        ZStack {
            TabView {
                
                // 1. Home Tab
                HomeView(isDrawerOpen: $isDrawerOpen)
                    .tabItem {
                        Image(systemName: "house")
                           
                            // Home icon
                        Text("Home")
                            
                    }
                
                // 2. Notifications Tab
                NotificationsView()
                    .tabItem {
                        Image(systemName: "bell") // Bell icon
                            
                        Text("Notifications")
                    }
                
                // 3. Job Post Tab
                JobPostView()
                    .tabItem {
                        Image(systemName: "plus.circle") // Plus circle icon
                        Text("Post Job")
                    }
                
                // 4. Chat Tab
                ChatView()
                    .tabItem {
                        Image(systemName: "message") // Chat bubble icon
                        Text("Chat")
                    }
                
                // 5. Profile Tab
                MyProfileView()
                    .tabItem {
                        Image(systemName: "person") // Human icon
                        Text("Profile")
                    }
            }
            .tint(.green)
            
            
            if isDrawerOpen {
                // Background overlay (full screen, including tab bar)
                Color.black.opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isDrawerOpen = false
                        }
                    }
                
                // Drawer View
                HStack {
                    DrawerView()
                        .frame(width: UIScreen.main.bounds.width * 0.8) // 70% of screen
                        .transition(.move(edge: .leading))
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
            }}
        
    }
}

#Preview {
    Navigations()
}
