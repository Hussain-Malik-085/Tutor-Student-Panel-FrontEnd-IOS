//
//  DrawerView.swift
//  Tutor Panel
//
//  Created by MetaDots on 23/09/2025.
//

import SwiftUI

struct DrawerView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // User Info
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "person.circle.fill") // Replace with profile image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                
                Text("Peter Park")
                    .font(.headline)
                Text("peterpark@example.com")
                    .font(.caption)
                
            }
            .padding(.top, 40)
             
            Divider().padding(.vertical, 6)
            
            // Menu Items
            VStack(alignment: .leading, spacing: 25) {
                Text("MENU")
                MenuItem(icon: "bookmark", title: "Saved Teachers")
                MenuItem(icon: "briefcase", title: "Posted Jobs")
                MenuItem(icon: "message", title: "Messages")
                MenuItem(icon: "gearshape", title: "Account Settings")
                MenuItem(icon: "info.circle", title: "About Us")
                MenuItem(icon: "doc.text", title: "Terms of Use")
            }
            
            Spacer()
            
            // Logout Button
            Button(action: {
                // TODO: Add logout functionality later
            }) {
                Text("Log Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.bottom, 30)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

// Reusable Menu Item
struct MenuItem: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName:icon)
                .frame(width: 24, height: 24)
               
            Text(title)
                .font(.system(size: 16))
        }
    }
}


#Preview {
    DrawerView()
}
