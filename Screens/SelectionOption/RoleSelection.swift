import SwiftUI

struct RoleSelection: View {
    @State private var selectedRole: String? = "student" // Default role
    @State private var isLoading = false
    @State private var navigateNext = false
    @State private var errorMessage: String? = nil
    
    // ✅ User ID aur Token UserDefaults se fetch karo
    let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    let token = UserDefaults.standard.string(forKey: "authToken") ?? ""
    
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
                
                // ✅ Teacher button
                Text("I am a Teacher")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.99, green: 0.97, blue: 0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(selectedRole == "tutor" ? Color.blue : Color.clear, lineWidth: 2)
                    )
                    .cornerRadius(20)
                    .onTapGesture {
                        selectedRole = "tutor"
                        updateRoleOnServer(role: "tutor")
                    }
                
                // ✅ Student button
                Text("I am a Student")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.99, green: 0.97, blue: 0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(selectedRole == "student" ? Color.blue : Color.clear, lineWidth: 2)
                    )
                    .cornerRadius(20)
                    .padding(.top)
                    .onTapGesture {
                        selectedRole = "student"
                        updateRoleOnServer(role: "student")
                    }
                
                Spacer()
                
          
                // ✅ Next button with conditional navigation
                NavigationLink(
                    destination: Group {
                        if selectedRole == "student" {
                            BasicInfoProfile()
                        } else {
                            CreateProfileAboutUS()
                        }
                    },
                    isActive: $navigateNext
                ) {
                    Text(isLoading ? "Updating..." : "Create your Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(13)
                        .frame(maxWidth: .infinity)
                        .background(isLoading ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
                        .cornerRadius(10)
                        .padding(.vertical)
                }
                .disabled(isLoading || userId.isEmpty)


                

                // Error Message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
        }
    }
    
    // 🔹 API Call
    func updateRoleOnServer(role: String) {
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        guard !userId.isEmpty else {
            print("❌ UserID not found in UserDefaults")
            return
        }
        
        guard let url = URL(string:"http://localhost:8020/app/api/\(userId)/role") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Token add karo
        let token = UserDefaults.standard.string(forKey: "authToken") ?? ""
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = ["role": role]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        isLoading = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    print("Error updating role: \(error)")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("📡 Status Code: \(httpResponse.statusCode)")
                }
                print("✅ Role updated to \(role)")
                navigateNext = true
            }
        }.resume()
    }

}



#Preview {
    RoleSelection()
}
