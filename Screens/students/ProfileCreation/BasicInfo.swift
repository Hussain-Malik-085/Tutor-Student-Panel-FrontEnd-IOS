//
//  BasicInfo.swift
//  Tutor Panel
//
//  Created by MetaDots on 19/09/2025.
//

import SwiftUI

struct BasicInfoProfile: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var phonenumber: String = ""
    @State private var selectedAge: String = ""
    @State private var selectedDate: Date? = nil
    @State private var showDatePicker = false
    @State private var isLoading: Bool = false
    @State private var navigateToNext = false
    
    let items = [
        "Basic Info  >",
        "Photo  >",
        "Academic Info  >",
    ]
    
    @State private var currentPhase: String = "Basic Info  >"
    private let ages: [String] = (1...90).map { "\($0)" }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Back Button
                HStack {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Create Your Profile")
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 10)
                
                // Horizontal Phase Scroll
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(items, id: \.self) { item in
                            Text(item)
                                .font(.caption)
                                .foregroundColor(item == currentPhase ? .red : .black)
                                .fontWeight(item == currentPhase ? .bold : .regular)
                        }
                    }
                }
                
                Text("Basic Info")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .font(.caption)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 2)
                
                Spacer()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Username
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Full Name")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                            TextField("E.g. Steve Smith", text: $username)
                                .padding(13)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .disabled(true)
                        }
                        
                        // Email
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Email Address")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                            TextField("Enter your Email Address", text: $email)
                                .padding(13)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .disabled(true)
                        }
                        
                        // Phone
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Phone Number")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                            TextField("Phone Number", text: $phonenumber)
                                .keyboardType(.numberPad)
                                .padding(13)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .onChange(of: phonenumber) { _, newValue in
                                    let filtered = newValue.filter { $0.isNumber }
                                    phonenumber = String(filtered.prefix(11))
                                }
                        }
                        
                        // Age
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Select Age")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                            HStack {
                                Text(selectedAge.isEmpty ? "Age" : selectedAge)
                                    .foregroundColor(selectedAge.isEmpty ? .gray : .black)
                                Spacer()
                                Menu {
                                    ForEach(ages, id: \.self) { age in
                                        Button(action: {
                                            selectedAge = age
                                        }) {
                                            Text(age)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                        
                        // DOB
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Date of Birth")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                            HStack {
                                Text(selectedDate == nil ? "Select Date" : formatDate(selectedDate!))
                                    .foregroundColor(selectedDate == nil ? .gray : .black)
                                Spacer()
                                Button(action: { showDatePicker.toggle() }) {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                        }
                        .sheet(isPresented: $showDatePicker) {
                            VStack {
                                DatePicker(
                                    "Pick your DOB",
                                    selection: Binding(
                                        get: { selectedDate ?? Date() },
                                        set: { selectedDate = $0 }
                                    ),
                                    displayedComponents: .date
                                )
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                                .padding()
                                
                                Button("Done") {
                                    showDatePicker = false
                                }
                                .padding()
                            }
                        }
                        
                        // Error Message
                        if showError {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        Spacer()
                        Spacer()}
                        // Next Button
                        Button(action: {
                            isLoading = true
                                sendProfileData { success in
                                    isLoading = false
                                    if success {
                                        navigateToNext = true   // 👉 ye navigation ko trigger karega
                                    }
                                }
                        }) {
                            Text(isLoading ? "Saving..." : "Next")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                                .cornerRadius(10)
                                .disabled(isLoading)
                        }
                        .background(
                            NavigationLink(
                          destination: ProfilePicture(),
                           isActive: $navigateToNext   // 👉 ab navigateToNext state se link hoga
                            ) { EmptyView() }
                        )
                        
                    }
                    .padding(.bottom, 20)
                
            }
            .padding()
            .navigationBarHidden(true)
            .onAppear {
                loadSavedUserData()
                fetchProfileData()
            }
        }
    }
    
    // MARK: - Helper for date formatting
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    // MARK: - Load saved username/email
    private func loadSavedUserData() {
        if let savedUsername = UserDefaults.standard.string(forKey: "Username") {
            username = savedUsername
        }
        if let savedEmail = UserDefaults.standard.string(forKey: "Email") {
            email = savedEmail
        }
    }
    
    // MARK: - Fetch Profile from Backend
    private func fetchProfileData() {
        guard let url = URL(string: "http://localhost:8020/app/student/getbasicinfo") else {
            print("❌ Invalid URL")
            return
        }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            print("❌ No auth token found")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    showError = true
                    errorMessage = "Error fetching profile: \(error.localizedDescription)"
                    print("❌ Error fetching profile: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    showError = true
                    errorMessage = "No data received from server"
                    print("❌ No data received from server")
                }
                return
            }
            
            do {
                // Parse JSON outside the conditional
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    DispatchQueue.main.async {
                        showError = true
                        errorMessage = "Invalid JSON response"
                        print("❌ Invalid JSON response")
                    }
                    return
                }
                
                // Check status
                if let status = json["status"] as? Int, status == 1,
                   let profileData = json["data"] as? [String: Any] {
                    DispatchQueue.main.async {
                        username = profileData["Username"] as? String ?? username
                        email = profileData["Email"] as? String ?? email
                        phonenumber = profileData["Phone"] as? String ?? ""
                        selectedAge = profileData["Age"] as? String ?? ""
                        
                        if let dobString = profileData["DOB"] as? String {
                            let formatter = ISO8601DateFormatter()
                            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                            selectedDate = formatter.date(from: dobString)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        showError = true
                        errorMessage = json["message"] as? String ?? "Failed to parse profile data"
                        print("❌ Failed to parse JSON response: \(json)")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    showError = true
                    errorMessage = "Error parsing response: \(error.localizedDescription)"
                    print("❌ Error parsing JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    // MARK: - Send Profile Data to Backend
    private func sendProfileData(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8020/app/student/basicinfo") else {
            showError = true
            errorMessage = "Invalid URL"
            print("❌ Invalid URL")
            completion(false)
            return
        }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            showError = true
            errorMessage = "No auth token found"
            print("❌ No auth token found")
            completion(false)
            return
        }
        
        // Validate required fields
        guard !phonenumber.isEmpty, !selectedAge.isEmpty, selectedDate != nil else {
            showError = true
            errorMessage = "Please fill in all required fields"
            print("❌ Missing required fields")
            completion(false)
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dobString = selectedDate != nil ? formatter.string(from: selectedDate!) : ""
        
        // Match backend expected field names
        let body: [String: Any] = [
            "Username": username,
            "Email": email,
            "PhoneNumber": phonenumber,
            "Age": selectedAge,
            "DOB": dobString
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            DispatchQueue.main.async {
                showError = true
                errorMessage = "Error preparing data: \(error.localizedDescription)"
                print("❌ Error serializing JSON: \(error.localizedDescription)")
            }
            completion(false)
            return
        }
        
        isLoading = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    showError = true
                    errorMessage = "Error sending profile: \(error.localizedDescription)"
                    print("❌ Error sending profile: \(error.localizedDescription)")
                }
                completion(false)
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    showError = true
                    errorMessage = "No data received from server"
                    print("❌ No data received from server")
                }
                completion(false)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let status = json["status"] as? Int {
                    if status == 1 {
                        DispatchQueue.main.async {
                            print("✅ Profile saved response: \(json)")
                            completion(true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            showError = true
                            errorMessage = json["Messege"] as? String ?? "Failed to save profile"
                            print("❌ Failed to save profile: \(json)")
                            completion(false)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        showError = true
                        errorMessage = "Invalid response from server"
                        print("❌ Invalid JSON response")
                        completion(false)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    showError = true
                    errorMessage = "Error parsing response: \(error.localizedDescription)"
                    print("❌ Error parsing JSON: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }.resume()
    }
}

#Preview {
    BasicInfoProfile()
}
