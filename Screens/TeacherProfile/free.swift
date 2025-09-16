import SwiftUI
import FirebaseAuth // ✅ Firebase import

struct Login1: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToRoleSelection = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Log In Now!")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        
                        Text("Welcome back! Please login to continue.")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .padding(.bottom, 4)
                        
                        // Email
                        Text("Email")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                        
                        HStack {
                            TextField("Enter Email", text: $username)
                                .padding(13)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                        
                        // Password
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
                        
                        // Forgot password
                        NavigationLink(destination: ForgotPassword()) {
                            Text("Forgot Password?")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .underline()
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
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
                        
                        // OR Divider
                        HStack {
                            Rectangle().frame(height: 0.5).foregroundColor(.gray)
                            Text("OR").padding(.horizontal, 4).font(.caption2).foregroundColor(.gray)
                            Rectangle().frame(height: 0.5).foregroundColor(.gray)
                        }
                        .padding(.vertical, 10)
                        
                        // Google Button
                        Button(action: {
                            loginWithGoogle()
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
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
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
                        
                        // Signup Link
                        HStack(spacing: 4) {
                            Text("Don't have an Account?")
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
                .padding()
            }
            .navigationDestination(isPresented: $navigateToRoleSelection) {
                RoleSelection()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: - Normal Login API Call
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            handleResponse(data: data, error: error)
        }.resume()
    }
    
    // MARK: - Google Login (Firebase + Backend)
    func loginWithGoogle() {
        // ✅ Firebase se sign in karna (Google Sign In SDK ya WebView se)
        // Example: agar tum already Firebase auth use kar rahe ho
        // Yeh sirf idToken uthata hai
        Auth.auth().signIn(withEmail: "demo@gmail.com", password: "123456") { result, error in
            if let error = error {
                self.alertMessage = "Firebase login failed: \(error.localizedDescription)"
                self.showAlert = true
                return
            }
            result?.user.getIDToken { idToken, error in
                if let idToken = idToken {
                    // Backend ko bhejo
                    sendFirebaseTokenToBackend(idToken: idToken)
                }
            }
        }
    }
    
    func sendFirebaseTokenToBackend(idToken: String) {
        guard let url = URL(string: "http://localhost:8020/app/firebase-login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            handleResponse(data: data, error: error)
        }.resume()
    }
    
    // MARK: - Handle API Response (Common for both logins)
    func handleResponse(data: Data?, error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                self.alertMessage = "Network error: \(error.localizedDescription)"
                self.showAlert = true
                return
            }
            guard let data = data else {
                self.alertMessage = "No data received"
                self.showAlert = true
                return
            }
            if let responseJSON = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let status = responseJSON["status"] as? Int,
               let message = responseJSON["message"] as? String {
                
                if status == 1 {
                    self.alertMessage = message
                    self.showAlert = true
                    
                    // ✅ Save token
                    if let token = responseJSON["token"] as? String {
                        UserDefaults.standard.set(token, forKey: "authToken")
                        print("Saved token: \(token)")
                    }
                    
                    // ✅ Save user info
                    if let userData = responseJSON["data"] as? [String: Any] {
                        if let uname = userData["Username"] as? String {
                            UserDefaults.standard.set(uname, forKey: "Username")
                        }
                        if let uemail = userData["Email"] as? String {
                            UserDefaults.standard.set(uemail, forKey: "Email")
                        }
                    }
                    
                    // Navigate
                    self.navigateToRoleSelection = true
                } else {
                    self.alertMessage = message
                    self.showAlert = true
                }
            } else {
                self.alertMessage = "Invalid response from server"
                self.showAlert = true
            }
        }
    }
}

#Preview {
    Login1()
}
