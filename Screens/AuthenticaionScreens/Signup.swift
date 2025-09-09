//
//  Signup.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/08/2025.
//

//
//  FirstScreen.swift
//  TestApp
//
//  Created by MetaDots on 21/08/2025.
//

//import SwiftUI
//
//struct Signup: View {
//    @State private var username: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    var body: some View {
//        NavigationStack {
//            VStack {
//                ScrollView {
//                    
//                    VStack(alignment: .leading, spacing: 10) {
//                        
//                        
//                        Text("Sign Up Now!")
//                            .font(.system(size: 30))
//                           // .font(.largeTitle)
//                            .fontWeight(.bold)
//                        
//                        
//                        Text("")
//                            .font(.system(size: 12))
//                            .fontWeight(.light)
//                            .padding(.bottom, 4)
//                        
//                        
//                        Text("User Name")
//                            .font(.system(size: 12))
//                            .fontWeight(.medium)
//                        
//                        HStack {
//                            TextField("Enter your username", text: $username)
//                                .padding(13)
//                            Image(systemName: "person.fill")
//                                .foregroundColor(.gray)
//                                .padding(.trailing, 20)
//                        }
//                        .background(Color.gray.opacity(0.1))
//                        .cornerRadius(10)
//                        .padding(.vertical,2)
//                        
//                        
//                        
//                        Text("Email Address")
//                            .font(.system(size: 12))
//                            .fontWeight(.medium)
//                        
//                        HStack {
//                            TextField("Enter your Email Address", text: $email)
//                                .padding(13)
//                            Image(systemName: "envelope.badge")
//                                .foregroundColor(.gray)
//                                .padding(.trailing, 20)
//                        }
//                        .background(Color.gray.opacity(0.1))
//                        .cornerRadius(10)
//                        .padding(.vertical,2)
//                        
//                        
//                        Text("Password")
//                            .font(.system(size: 12))
//                            .fontWeight(.medium)
//                        
//                        HStack {
//                            TextField("Enter Password", text: $password)
//                                .padding(13)
//                            Image(systemName: "lock.open.fill")
//                                .foregroundColor(.gray)
//                                .padding(.trailing, 20)
//                        }
//                        .background(Color.gray.opacity(0.1))
//                        .cornerRadius(10)
//                        .padding(.vertical,2)
//                        
//                        
//                        Button(action: {
//                            print("Create an Account button pressed")
//                        }) {
//                            Text("Create an Account")
//                                .font(.headline)
//                                .foregroundColor(.white)
//                                .padding(13)
//                                .frame(maxWidth: .infinity)
//                                .background(Color(red: 12/255, green: 144/255, blue: 121/255))
//                                .cornerRadius(10)
//                                .padding(.vertical)
//                        }
//                        
//                        
//                        HStack {
//                            Rectangle()
//                                .frame(height: 0.1) // line ki height fix
//                                .foregroundColor(.black)
//                            
//                            Text("OR")
//                                .padding(.horizontal, 4)
//                                .font(.caption2)
//                                .foregroundColor(.gray)
//                            
//                            Rectangle()
//                                .frame(height: 0.1)
//                                .foregroundColor(.black)
//                        }
//                        Spacer()
//                        
//                        
//                        Button(action: {
//                            print("Continue with Google button pressed")
//                        }) {
//                            HStack {
//                                Image("google") // <-- custom Google icon
//                                    .resizable()
//                                    .frame(width: 20, height: 20)
//                                    .padding(.trailing, 10)
//                                
//                                
//                                Text("Continue With Google")
//                                    .font(.system(size: 16))
//                                    .foregroundColor(.black)
//                            }
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.black, lineWidth: 1)   // border banay ga aur curve follow karega
//                            )
//                            .cornerRadius(10)
//                            
//                        }
//                       
//                        Spacer()
//                        
//                        
//                        Button(action: {
//                            print("Continue with FaceBook button pressed")
//                        }) {
//                            HStack {
//                                Image("facebook")
//                                    .resizable()
//                                    .frame(width: 20, height: 20)
//                                    .padding(.trailing, 10)
//                                
//                                
//                                Text("Continue With Facebook")
//                                    .font(.system(size: 16))
//                                    .foregroundColor(.black)
//                            }
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.black, lineWidth: 1)   // border banay ga aur curve follow karega
//                            )
//                            .cornerRadius(10)
//                        }
//                        Spacer()
//                        
//                        VStack {
//                          
//                            
//                            HStack(spacing: 4) {
//                                Text("Already have an Account?")
//                                    .font(.system(size: 14))
//                                    .foregroundColor(.gray)
//                                
//                                NavigationLink(destination: Login()) {
//                                    Text("Log In")
//                                        .font(.system(size: 14))
//                                        .foregroundColor(.blue)
//                                }
//                            }
//                            .frame(maxWidth: .infinity, alignment: .center) // force center
//                        }
//
//                        
//                    }
//                    
//                    
//                    
//                    
//                    
//                }
//                .padding()
//            }}
//        }
//    }
//
//#Preview {
//    Signup()
//}


import SwiftUI

struct Signup: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        // ... [UI as before] ...

                        Text("Sign Up Now!")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        Text("")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .padding(.bottom, 4)
                        
                        Text("User Name")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                        
                        HStack {
                            TextField("Enter your username", text: $username)
                                .padding(13)
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                        
                        Text("Email Address")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                        
                        HStack {
                            TextField("Enter your Email Address", text: $email)
                                .padding(13)
                            Image(systemName: "envelope.badge")
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                        
                        Text("Password")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                        
                        HStack {
                            SecureField("Enter Password", text: $password)
                                .padding(13)
                            Image(systemName: "lock.open.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                        
                        // --- CHANGED BUTTON ACTION BELOW ---
                        Button(action: {
                            signupUser()  // <-- API function call yahan
                        }) {
                            Text("Create an Account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(13)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                                .cornerRadius(10)
                                .padding(.vertical)
                        }
                        // --- END CHANGE ---
                        
                        // ... [rest of your UI as before] ...
                        
                        HStack {
                            Rectangle()
                                .frame(height: 0.1)
                                .foregroundColor(.black)
                            Text("OR")
                                .padding(.horizontal, 4)
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Rectangle()
                                .frame(height: 0.1)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Button(action: {
                            print("Continue with Google button pressed")
                        }) {
                            HStack {
                                Image("google")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 10)
                                Text("Continue With Google")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .cornerRadius(10)
                        }
                        Spacer()
                        Button(action: {
                            print("Continue with FaceBook button pressed")
                        }) {
                            HStack {
                                Image("facebook")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 10)
                                Text("Continue With Facebook")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .cornerRadius(10)
                        }
                        Spacer()
                        VStack {
                            HStack(spacing: 4) {
                                Text("Already have an Account?")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                NavigationLink(destination: Login()) {
                                    Text("Log In")
                                        .font(.system(size: 14))
                                        .foregroundColor(.blue)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .padding()
            }
        }
        // --- ALERT FOR RESPONSE ---
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
    
    // --- API CALL FUNCTION ADDED HERE ---
    func signupUser() {
        guard let url = URL(string: "http://localhost:8020/app/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "Username": username,
            "Email": email,
            "Password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                guard let data = data else {
                    alertMessage = "No data received"
                    showAlert = true
                    return
                }
                if let responseString = String(data: data, encoding: .utf8) {
                    alertMessage = responseString
                    showAlert = true
                } else {
                    alertMessage = "Unknown response"
                    showAlert = true
                }
            }
        }
        task.resume()
    }
    // --- END API CALL FUNCTION ---
}

#Preview {
    Signup()
}
