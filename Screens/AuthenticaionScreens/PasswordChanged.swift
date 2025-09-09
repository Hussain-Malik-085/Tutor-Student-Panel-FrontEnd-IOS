
//

import SwiftUI

struct PasswordChanged: View {
   
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                
                VStack {
                    ScrollView {
                        Spacer()
                            .frame(height: geo.size.height * 0.49)
                        
                        VStack(alignment: .center, spacing: 10) {
                            Text("Password Changed")
                                .font(.system(size: 20))
                            // .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            
                            Text("Your password has been changed successfully!")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                
                            Spacer()
                                .frame(height: geo.size.height * 0.26)
                          
                            NavigationLink(destination: Login()) {
                                Text("Go Back to Login")
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
                      
                    }
                    .padding()
                }}}
        }
    }

#Preview {
    PasswordChanged()
}
//
//  ForgotPassword.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/08/2025.
//

//
//  SetNewPassword.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/08/2025.
//

