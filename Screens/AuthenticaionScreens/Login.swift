//
////
//
//import SwiftUI
//
//struct Login: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//    var body: some View {
//        NavigationStack {
//            VStack {
//                ScrollView {
//                    
//                    VStack(alignment: .leading, spacing: 10) {
//                        
//                        
//                        Text("Log In Now!")
//                            .font(.system(size: 30))
//                           // .font(.largeTitle)
//                            .fontWeight(.bold)
//                        
//                        
//                        Text("hi Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
//                            .font(.system(size: 12))
//                            .fontWeight(.light)
//                            .padding(.bottom, 4)
//                        
//                        
//                        Text("Username or Email")
//                            .font(.system(size: 12))
//                            .fontWeight(.medium)
//                        
//                        HStack {
//                            TextField("Username or Email", text: $username)
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
//                        
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
//                        Spacer()
//                        VStack {
//                                NavigationLink(destination: ForgotPassword()) {
//                                    Text("Forgot Password?")
//                                        .font(.system(size: 14))
//                                        .foregroundColor(.black)
//                                        .underline()
//                                }
//                            
//                                .frame(maxWidth: .infinity, alignment: .trailing)
//                        }
//                        
//                        NavigationLink(destination: RoleSelection()) {
//                                   Text("Log In Your Account")
//                                       .font(.headline)
//                                       .foregroundColor(.white)
//                                       .padding(13)
//                                       .frame(maxWidth: .infinity)
//                                       .background(Color(red: 12/255, green: 144/255, blue: 121/255))
//                                       .cornerRadius(10)
//                                       .padding(.vertical)
//                               }
//                        .simultaneousGesture(TapGesture().onEnded {
//                            print("Login to your account button pressed")
//                        })
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
//                                NavigationLink(destination: Signup()) {
//                                    Text("Sign Up")
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
//                }
//                .padding()
//            }}
//        }
//    }
//
//#Preview {
//    Login()
//}



import SwiftUI

struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToRoleSelection = false // Added for navigation

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Log In Now!")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        
                        Text("hi Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .padding(.bottom, 4)
                        
                        Text("Username or Email")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                        
                        HStack {
                            TextField("Username or Email", text: $username)
                                .padding(13)
                            Image(systemName: "person.fill")
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
                            SecureField("Enter Password", text: $password) // Changed to SecureField for password
                                .padding(13)
                            Image(systemName: "lock.open.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                        
                        Spacer()
                        
                        VStack {
                            NavigationLink(destination: ForgotPassword()) {
                                Text("Forgot Password?")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                    .underline()
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                        // Login Button
                        Button(action: {
                            loginUser()
                        }) {
                            Text("Log In Your Account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(13)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                                .cornerRadius(10)
                                .padding(.vertical)
                        }
                        
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
                                
                                NavigationLink(destination: Signup()) {
                                    Text("Sign Up")
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
            // Hidden NavigationLink for programmatic navigation
            .navigationDestination(isPresented: $navigateToRoleSelection) {
                RoleSelection()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    // --- API CALL FUNCTION FOR LOGIN ---
    func loginUser() {
        guard let url = URL(string: "http://localhost:8020/app/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "email": username,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Network error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                guard let data = data else {
                    alertMessage = "No data received"
                    showAlert = true
                    return
                }
                if let responseJSON = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let status = responseJSON["status"] as? Int,
                   let message = responseJSON["message"] as? String {
                    
                    if status == 1 {
                        alertMessage = message
                        showAlert = true
                        
                        // ✅ Token uthao aur save karo
                        if let token = responseJSON["token"] as? String {
                            UserDefaults.standard.set(token, forKey: "authToken")
                            print("Saved token: \(token)")
                        }
                        
                        // ✅ User data uthao aur save karo
                        if let userData = responseJSON["data"] as? [String: Any] {
                            if let uname = userData["Username"] as? String {
                                UserDefaults.standard.set(uname, forKey: "Username")
                                print("Saved Username: \(uname)")
                            }
                            if let uemail = userData["Email"] as? String {
                                UserDefaults.standard.set(uemail, forKey: "Email")
                                print("Saved Email: \(uemail)")
                            }
                        }
                        
                        // Navigate to RoleSelection after successful login
                        navigateToRoleSelection = true
                        
                    } else {
                        alertMessage = message
                        showAlert = true
                    }
                } else {
                    alertMessage = "Invalid response"
                    showAlert = true
                }
            }
        }
        task.resume()
    }

    // --- END API CALL FUNCTION ---
}

#Preview {
    Login()
}
