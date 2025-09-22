

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToRoleSelection = false
    @State private var isLoading = false

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
                            SecureField("Enter Password", text: $password)
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
                        
                        // Traditional Login Button
                        Button(action: {
                            traditionalLogin()
                        }) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                        .foregroundColor(.white)
                                } else {
                                    Text("Log In Your Account")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                            .cornerRadius(10)
                            .padding(.vertical)
                        }
                        .disabled(isLoading)
                        
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
                        
                        // Google Sign In Button
                        Button(action: {
                            signInWithGoogle()
                        }) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                } else {
                                    Image("google") // Make sure you have google.png in your assets
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 10)
                                    
                                    Text("Continue With Google")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .cornerRadius(10)
                        }
                        .disabled(isLoading)
                       
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

    // MARK: - Traditional Login Function (Your existing code)
    func traditionalLogin() {
        isLoading = true
        
        guard let url = URL(string: "http://localhost:8020/app/login") else {
            isLoading = false
            return
        }
        
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
                isLoading = false
                
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
                        
                        // Save token and user data
                        if let token = responseJSON["token"] as? String {
                            UserDefaults.standard.set(token, forKey: "authToken")
                            print("Saved token: \(token)")
                        }
                        
                        if let userData = responseJSON["data"] as? [String: Any] {
                            if let uname = userData["Username"] as? String {
                                UserDefaults.standard.set(uname, forKey: "Username")
                                print("Saved Username: \(uname)")
                            }
                            if let uemail = userData["Email"] as? String {
                                UserDefaults.standard.set(uemail, forKey: "Email")
                                print("Saved Email: \(uemail)")
                            }
                            
                            if let uid = userData["_id"] as? String {
                                                        UserDefaults.standard.set(uid, forKey: "userId")
                                                        print("Saved UserId: \(uid)")
                                                    }
                        }
                        
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

    // MARK: - Firebase Google Sign In
    func signInWithGoogle() {
        isLoading = true
        
        guard let presentingViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("Could not get root view controller")
            isLoading = false
            return
        }
        
        // Configure Google Sign In
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Could not get Firebase client ID")
            isLoading = false
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start Google Sign In flow
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.isLoading = false
                    self.alertMessage = "Google Sign In failed: \(error.localizedDescription)"
                    self.showAlert = true
                    return
                }
                
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString else {
                    self.isLoading = false
                    self.alertMessage = "Failed to get Google ID token"
                    self.showAlert = true
                    return
                }
                
                // Create Firebase credential
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: user.accessToken.tokenString)
                
                // Sign in with Firebase
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        self.isLoading = false
                        self.alertMessage = "Firebase sign in failed: \(error.localizedDescription)"
                        self.showAlert = true
                        return
                    }
                    
                    // Get Firebase ID token to send to your backend
                    authResult?.user.getIDToken { idToken, error in
                        if let error = error {
                            self.isLoading = false
                            self.alertMessage = "Failed to get Firebase ID token: \(error.localizedDescription)"
                            self.showAlert = true
                            return
                        }
                        
                        guard let idToken = idToken else {
                            self.isLoading = false
                            self.alertMessage = "ID token is nil"
                            self.showAlert = true
                            return
                        }
                        
                        // Send token to your backend
                        self.sendFirebaseTokenToBackend(idToken: idToken)
                    }
                }
            }
        }
    }
    
    // MARK: - Send Firebase Token to Backend
    func sendFirebaseTokenToBackend(idToken: String) {
        guard let url = URL(string: "http://localhost:8020/app/firebase-login") else {
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.alertMessage = "Network error: \(error.localizedDescription)"
                    self.showAlert = true
                    return
                }
                
                guard let data = data else {
                    self.alertMessage = "No data received from backend"
                    self.showAlert = true
                    return
                }
                
                do {
                    if let responseJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let status = responseJSON["status"] as? Int,
                       let message = responseJSON["message"] as? String {
                        
                        if status == 1 {
                            // Success - save token and user data
                            if let token = responseJSON["token"] as? String {
                                UserDefaults.standard.set(token, forKey: "authToken")
                                print("Saved Firebase login token: \(token)")
                            }
                            
                            if let userData = responseJSON["data"] as? [String: Any] {
                                if let username = userData["Username"] as? String {
                                    UserDefaults.standard.set(username, forKey: "Username")
                                    print("Saved Username: \(username)")
                                }
                                if let email = userData["Email"] as? String {
                                    UserDefaults.standard.set(email, forKey: "Email")
                                    print("Saved Email: \(email)")
                                }
                                if let provider = userData["provider"] as? String {
                                    UserDefaults.standard.set(provider, forKey: "LoginProvider")
                                    print("Saved Provider: \(provider)")
                                }
                            }
                            
                            self.alertMessage = "Google login successful!"
                            self.showAlert = true
                            self.navigateToRoleSelection = true
                            
                        } else {
                            self.alertMessage = message
                            self.showAlert = true
                        }
                    } else {
                        self.alertMessage = "Invalid response from backend"
                        self.showAlert = true
                    }
                } catch {
                    self.alertMessage = "Failed to parse backend response: \(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        }
        task.resume()
    }
}

#Preview {
    Login()
}
