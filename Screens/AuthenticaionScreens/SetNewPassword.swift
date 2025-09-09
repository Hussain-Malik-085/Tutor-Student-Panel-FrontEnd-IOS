
//

import SwiftUI

struct SetNewPassword: View {
   
    @State private var password: String = ""
    @State private var confirmpassword: String = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    ScrollView {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            
                            Text("Set A New Password")
                                .font(.system(size: 30))
                            // .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            
                            Text("New password must be different from your previous")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                
                            
                            Text("used passwords.")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .padding(.bottom, 4)
                            
                            Text("New Password")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                            
                            HStack {
                                TextField("Enter New Password", text: $password)
                                    .padding(13)
                                Image(systemName: "lock.open.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 20)
                            }
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.vertical,2)
                            
                            Text("Confirm New Password")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                            
                            HStack {
                                TextField("Enter Confirm New Password", text: $confirmpassword)
                                    .padding(13)
                                Image(systemName: "lock.open.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 20)
                            }
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                         
                        
                            Spacer()
                                .frame(height: geo.size.height * 0.46)
                            
                            
                            
                            NavigationLink(destination: PasswordChanged()) {
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
                        }
                      
                    }
                    .padding()
                }}}
        }
    }

#Preview {
    SetNewPassword()
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

