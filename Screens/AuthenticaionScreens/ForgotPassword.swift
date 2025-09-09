
//

import SwiftUI

struct ForgotPassword: View {
   
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    ScrollView {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            
                            Text("Forgot Password")
                                .font(.system(size: 30))
                            // .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            
                            Text("No worries, we’ll send you instructions for reset")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .padding(.bottom, 4)
                            
                            
                            Text("Email Address")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                            

                            
                            HStack {
                                TextField("Enter Email Address", text: $email)
                                    .padding(13)
                                Image(systemName: "person.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 20)
                            }
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.vertical,2)
                            
                            
                            
                            Spacer()
                                .frame(height: geo.size.height * 0.5)
                            
                            
                            
                            NavigationLink(destination: ForgotPassword1()) {
                                Text("Reset Password")
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
                            
                            
                            
                            
                            
                            NavigationLink(
                                destination: Login(),
                                label: {
                                    Text("Back To Log In")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 1)   // border banay ga aur curve follow karega
                                        )
                                        .cornerRadius(10)
                                        
                                }
                            )
                            .simultaneousGesture(TapGesture().onEnded {
                                print("Back to Login button pressed")
                            })
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                    }
                    .padding()
                }}}
        }
    }

#Preview {
    ForgotPassword()
}
//
//  ForgotPassword.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/08/2025.
//

