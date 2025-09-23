import SwiftUI

struct CreateProfileDescription: View {
    @Environment(\.dismiss) var dismiss
    @State private var introduction: String = ""
    @State private var teaching: String = ""
    @State private var motivate: String = ""
    @State private var headline: String = ""
    @State private var currentPhase: String = "Description >"
    
    // States
    @State private var isLoading = false
    @State private var hasExistingData = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToAvailability = false
    
    let items = [
        "About Us >", "Photo >", "Certification >", "Education >",
        "Skills >", "Description >", "Availability >", "ID Card Verification "
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Back button aur title
                HStack {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                            Text("Create Your Profile")
                                .foregroundColor(.black)
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 8)
                
                // Horizontal phase indicator
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(items, id: \.self) { item in
                                Text(item)
                                    .font(.caption)
                                    .foregroundColor(item == currentPhase ? .red : .black)
                                    .fontWeight(item == currentPhase ? .bold : .regular)
                                    .id(item)
                            }
                        }
                    }
                    .onChange(of: currentPhase) { oldValue, newValue in
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .leading)
                        }
                    }
                    .onAppear {
                        proxy.scrollTo(currentPhase, anchor: .leading)
                    }
                }
                .padding(.bottom, 12)
                
                // Section Title
                Text("Profile Description")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Tell your story in a few words. Make your profile stand out with a clear description.")
                    .font(.caption)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                
                // ScrollView content
                ScrollView {
                    VStack(spacing: 12) {
                        // Introduction
                        Text("1. Introduction Yourself")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextEditor(text: $introduction)
                            .frame(height: 120)
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .disableAutocorrection(true)
                        
                        Text("Total words you typed: \(introduction.split(whereSeparator: { $0.isWhitespace }).count)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        // Teaching
                        Text("2. Teaching Experience")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextEditor(text: $teaching)
                            .frame(height: 120)
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .disableAutocorrection(true)
                        
                        Text("Total words you typed: \(teaching.split(whereSeparator: { $0.isWhitespace }).count)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        // Motivate
                        Text("3. Motivate Potential Students")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextEditor(text: $motivate)
                            .frame(height: 120)
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .disableAutocorrection(true)
                        
                        Text("Total words you typed: \(motivate.split(whereSeparator: { $0.isWhitespace }).count)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        // Headline
                        Text("4. Write a Catchy Headline")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextEditor(text: $headline)
                            .frame(height: 120)
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .disableAutocorrection(true)
                        
                        Text("Total words you typed: \(headline.split(whereSeparator: { $0.isWhitespace }).count)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 20)
                }
                
                // Navigation buttons
                HStack {
                    // Previous button
                    NavigationLink(destination: CreateProfileEducation()) {
                        Text("Previous")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                    
                    // Save & Next button
                    Button(action: {
                        Task {
                            await handleSaveAndNext()
                        }
                    }) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text(hasExistingData ? "Update & Next" : "Save & Next")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(isLoading)
                    .padding(13)
                    .frame(maxWidth: .infinity)
                    .background(isLoading ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
                    .cornerRadius(10)
                }
                
                // Hidden NavigationLink for programmatic navigation
                NavigationLink(
                    destination: CompletingProfileTutor(),
                    isActive: $navigateToAvailability
                ) { EmptyView() }
            }
            .padding()
            .navigationBarHidden(true)
            .alert("Profile Description", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    // Navigation after successful save
                    if alertMessage.contains("successfully") || alertMessage.contains("Successfully") {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            navigateToAvailability = true
                        }
                    }
                }
            } message: {
                Text(alertMessage)
            }
            .onAppear {
                Task {
                    await fetchProfileDescription()
                }
            }
        }
    }
    
    /// Handle Save and Next Action
    @MainActor
    func handleSaveAndNext() async {
        isLoading = true
        let success = await saveProfileDescription()
        isLoading = false
        
        if success {
            // Navigation will happen in alert OK button
            // This ensures proper UI update
        }
    }
    
    /// Save API Call - Fixed field name mapping
    func saveProfileDescription() async -> Bool {
        // Validation
        guard !introduction.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !teaching.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !motivate.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !headline.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            await MainActor.run {
                alertMessage = "Please fill all fields before saving."
                showAlert = true
            }
            return false
        }
        
        // Fixed: Backend expects these exact field names
        let parameters: [String: String] = [
            "Introduction": introduction.trimmingCharacters(in: .whitespacesAndNewlines),
            "Teaching": teaching.trimmingCharacters(in: .whitespacesAndNewlines),
            "Motivation": motivate.trimmingCharacters(in: .whitespacesAndNewlines),
            "Headline": headline.trimmingCharacters(in: .whitespacesAndNewlines)
        ]
        
        guard let url = URL(string: "http://localhost:8020/app/tutor/createdescription") else {
            await MainActor.run {
                alertMessage = "Invalid URL"
                showAlert = true
            }
            return false
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let token = UserDefaults.standard.string(forKey: "authToken") {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                await MainActor.run {
                    alertMessage = "No authentication token found. Please log in."
                    showAlert = true
                }
                return false
            }
            
            // Debug print
            print("Sending parameters: \(parameters)")
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Debug print response
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                await MainActor.run {
                    alertMessage = "Invalid response from server."
                    showAlert = true
                }
                return false
            }
            
            if httpResponse.statusCode == 200 {
                let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                if let status = jsonResponse?["status"] as? Int, status == 1 {
                    await MainActor.run {
                        alertMessage = jsonResponse?["message"] as? String ?? "Description saved successfully!"
                        hasExistingData = true
                        showAlert = true
                    }
                    return true
                } else {
                    await MainActor.run {
                        alertMessage = jsonResponse?["message"] as? String ?? "Error saving description."
                        showAlert = true
                    }
                    return false
                }
            } else if httpResponse.statusCode == 401 {
                await MainActor.run {
                    alertMessage = "Unauthorized: Invalid or missing token."
                    showAlert = true
                }
                return false
            } else {
                await MainActor.run {
                    alertMessage = "Failed to save description. Status: \(httpResponse.statusCode)"
                    showAlert = true
                }
                return false
            }
        } catch {
            await MainActor.run {
                alertMessage = "Error: \(error.localizedDescription)"
                showAlert = true
            }
            print("Save error: \(error)")
            return false
        }
    }
    
    /// Fetch API Call - Fixed field name mapping
    func fetchProfileDescription() async {
        guard let url = URL(string: "http://localhost:8020/app/tutor/getdescription") else {
            await MainActor.run {
                alertMessage = "Invalid URL"
                showAlert = true
            }
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let token = UserDefaults.standard.string(forKey: "authToken") {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                print("No auth token found for fetch")
                return
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Debug print
            if let responseString = String(data: data, encoding: .utf8) {
                print("Fetch response: \(responseString)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            print("Fetch status code: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode == 200 {
                let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                print("JSON Response: \(jsonResponse ?? [:])")
                
                if let status = jsonResponse?["status"] as? Int,
                   status == 1,
                   let data = jsonResponse?["data"] as? [String: Any] {
                    
                    await MainActor.run {
                        // Fixed: Backend returns these field names
                        introduction = data["Introduction"] as? String ?? ""
                        teaching = data["Teaching"] as? String ?? ""
                        motivate = data["Motivation"] as? String ?? ""
                        headline = data["Headline"] as? String ?? ""
                        hasExistingData = true
                        
                        print("Data loaded - Intro: \(introduction.prefix(50))...")
                    }
                } else {
                    print("No data found or status is 0")
                }
            } else {
                print("HTTP Error: \(httpResponse.statusCode)")
            }
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CreateProfileDescription()
}
