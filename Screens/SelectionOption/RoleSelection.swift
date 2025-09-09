
import SwiftUI

struct RoleSelection: View {
    @State private var selectedRole: String? = nil
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "bolt.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(red: 0.1, green: 0.9, blue: 0.6))
                    .frame(maxWidth: .infinity, alignment: .top) 
                
                
                
                Text("Join as a Teacher or Student")
                    .font(.body)
                    .padding(.leading,1)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                
                
              
                    Text("I am a Teacher")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.99, green: 0.97, blue: 0.8)
                        )// Values range from 0.0 to 1.0) // light green
                        .border(selectedRole == "teacher" ? Color.blue : Color.clear, width: 2) // Highlight only when selected
                        .cornerRadius(20)
                    
              
                .simultaneousGesture(TapGesture().onEnded {
                    selectedRole = "teacher"
                    print("Teacher button pressed")
                })
                
               
                    Text("I am a Student")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.99, green: 0.97, blue: 0.8)
                        )// Values range from 0.0 to 1.0) // light green
                        .border(selectedRole == "student" ? Color.blue : Color.clear, width: 2) // Highlight only when selected
                        .cornerRadius(20)
                        .padding(.top)
                
                .simultaneousGesture(TapGesture().onEnded {
                    selectedRole = "student"
                    print("Student button pressed")
                })
                Spacer()
                
                NavigationLink(destination: CreateProfileAboutUS()) {
                    Text("Create your Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(13)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                        .cornerRadius(10)
                        .padding(.vertical)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    print("Reset Password button pressed")
                })
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            
            
            .padding()
        }
    }
    
    
}
//
#Preview {
    RoleSelection()
}

//  Splash.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/08/2025.
//

