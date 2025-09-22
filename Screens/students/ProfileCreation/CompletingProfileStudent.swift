//
//  CompletingProfile.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/09/2025.
//

import SwiftUI

struct CompletingProfileStudent: View {
    @State private var navigateToNext = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Green checkmark circle
                ZStack {
                    Circle()
                        .stroke(Color.green, lineWidth: 3)
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.green)
                }
                .padding(.bottom, 40)
                
                // Success text
                Text("Your Profile Has Been Created Successfully!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                // Description text
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
                Spacer()
                
                // Continue button
                Button(action: {
                    navigateToNext = true
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                // Navigation to next screen
                NavigationLink(
                    destination: Login(), // Random screen
                    isActive: $navigateToNext
                ) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
            .background(Color.white)
        }
    }
}



#Preview {
    CompletingProfileStudent()
}

