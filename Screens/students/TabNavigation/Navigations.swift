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
                        Image(systemName: "house.fill") // Home icon
                        Text("Home")
                    }
                
                // 2. Notifications Tab
                NotificationsView()
                    .tabItem {
                        Image(systemName: "bell.fill") // Bell icon
                        Text("Notifications")
                    }
                
                // 3. Job Post Tab
                JobPostView()
                    .tabItem {
                        Image(systemName: "plus.circle.fill") // Plus circle icon
                        Text("Post Job")
                    }
                
                // 4. Chat Tab
                ChatView()
                    .tabItem {
                        Image(systemName: "message.fill") // Chat bubble icon
                        Text("Chat")
                    }
                
                // 5. Profile Tab
                MyProfileView()
                    .tabItem {
                        Image(systemName: "person.fill") // Human icon
                        Text("Profile")
                    }
            }
            
            
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
                        .frame(width: UIScreen.main.bounds.width * 0.7) // 70% of screen
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
