//
//  JobPost2.swift
//  Tutor Panel
//
//  Created by MetaDots on 25/09/2025.
//

//import SwiftUI
//
//struct JobPostType: View {
//    @Environment(\.dismiss) var dismiss
//    @State private var selectedJobType: String? = nil
//    @State private var isLoading = false
//    @State private var navigateNext = false
//    @State private var errorMessage: String? = nil
//    
//    // ✅ Previous screen se data receive karte hain
//    let jobTitle: String
//    
//    // ✅ User ID aur Token UserDefaults se fetch karo
//    let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
//    let token = UserDefaults.standard.string(forKey: "authToken") ?? ""
//    
//    var body: some View {
//        NavigationStack {
//            VStack(alignment: .leading, spacing: 20) {
//                
//                // Top Bar
//                HStack {
//                    Button(action: { dismiss() }) {
//                        HStack {
//                            Image(systemName: "chevron.left")
//                            Text("Post a Job")
//                        }
//                    }
//                    Spacer()
//                    Text("2/6")
//                }
//                .padding(.bottom, 10)
//                
//                // Heading + Info
//                VStack(alignment: .leading, spacing: 6) {
//                    Text("Job Type")
//                        .font(.headline)
//                    
//                    Text("Choose how this job will be performed: On-site, Remote, or Hybrid.")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//                
//                // Job Type Buttons
//                jobTypeButton(title: "Onsite Classes", type: "onsite")
//                jobTypeButton(title: "Remote Classes", type: "remote")
//                jobTypeButton(title: "Hybrid Classes", type: "hybrid")
//                
//                Spacer()
//                
//                // Helper Text
//                if selectedJobType == nil {
//                    Text("Please select a job type to continue")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                        .padding(.top, 5)
//                }
//                
//                // Error Message
//                if let errorMessage = errorMessage {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                        .padding(.top, 5)
//                }
//                
//                // Loading Indicator
//                if isLoading {
//                    HStack {
//                        ProgressView()
//                        Text("Creating job post...")
//                    }
//                    .padding(.top, 5)
//                }
//                
//                // Navigation Buttons
//                HStack {
//                    NavigationLink(destination: JobPostTitle()) {
//                        Text("Previous")
//                            .font(.headline)
//                            .foregroundColor(.black)
//                            .padding(13)
//                            .frame(maxWidth: .infinity)
//                            .background(.white)
//                            .cornerRadius(10)
//                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
//                    }
//                    
//                    // ✅ Final submission when job type is selected
//                    Button(action: {
//                        if let jobType = selectedJobType {
//                            submitJobPost(jobType: jobType)
//                        }
//                    }) {
//                        Text("Next")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding(13)
//                            .frame(maxWidth: .infinity)
//                            .background(selectedJobType == nil ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
//                            .cornerRadius(10)
//                    }
//                    .disabled(selectedJobType == nil || isLoading)
//                    
//                    // Navigate to next screen after successful submission
//                    NavigationLink(destination: JobPostLocation(jobTitle: "Sample Job Title"), isActive: $navigateNext) {
//                        EmptyView()
//                    }
//                }
//                .padding(.top, 10)
//            }
//            .padding()
//            .navigationBarHidden(true)
//        }
//    }
//    
//    // 🔹 Reusable button component
//    private func jobTypeButton(title: String, type: String) -> some View {
//        Text(title)
//            .font(.headline)
//            .foregroundColor(.black)
//            .padding(16)
//            .frame(maxWidth: .infinity)
//            .background(Color(red: 0.99, green: 0.97, blue: 0.8))
//            .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(selectedJobType == type ? Color.blue : Color.clear, lineWidth: 2)
//            )
//            .cornerRadius(20)
//            .onTapGesture {
//                if !isLoading {
//                    selectedJobType = type
//                }
//            }
//    }
//    
//    // 🔹 Final API Call - Submit complete job post
//    func submitJobPost(jobType: String) {
//        guard let url = URL(string:"http://localhost:8020/app/navigation/studentjobpost") else {
//            errorMessage = "Invalid URL"
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        
//        // ✅ Complete data bhejte hain
//        let body: [String: Any] = [
//            "jobTitle": jobTitle,
//            "jobType": jobType
//        ]
//        
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
//            errorMessage = "Failed to encode request"
//            return
//        }
//        
//        request.httpBody = jsonData
//        
//        isLoading = true
//        errorMessage = nil
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                isLoading = false
//            }
//            
//            if let error = error {
//                print("❌ Error creating job: \(error)")
//                DispatchQueue.main.async {
//                    errorMessage = "Network error: \(error.localizedDescription)"
//                }
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                DispatchQueue.main.async {
//                    errorMessage = "Invalid response"
//                }
//                return
//            }
//            
//            print("📡 Status Code: \(httpResponse.statusCode)")
//            
//            if let data = data {
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
//                        print("✅ Response: \(json)")
//                        
//                        if httpResponse.statusCode == 201 {
//                            print("✅ Job created successfully")
//                            DispatchQueue.main.async {
//                                navigateNext = true
//                            }
//                        } else {
//                            let message = json["message"] as? String ?? "Job creation failed"
//                            DispatchQueue.main.async {
//                                errorMessage = message
//                            }
//                        }
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        errorMessage = "Failed to parse response"
//                    }
//                }
//            }
//        }.resume()
//    }
//}
//
//#Preview {
//    JobPostType(jobTitle: "Sample Job Title")
//}



import SwiftUI

struct JobPostType2: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedJobType: String? = nil
    @State private var isLoading = false
    @State private var navigateNext = false
    @State private var errorMessage: String? = nil
    
    
    // ✅ Previous screen se data receive karte hain
    let jobTitle: String
    
    // ✅ User ID aur Token UserDefaults se fetch karo
    let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    let token = UserDefaults.standard.string(forKey: "authToken") ?? ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // Top Bar
                HStack {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Post a Job")
                        }
                    }
                    Spacer()
                    Text("2/6")
                }
                .padding(.bottom, 10)
                
                // Heading + Info
                VStack(alignment: .leading, spacing: 6) {
                    Text("Job Type")
                        .font(.headline)
                    
                    Text("Choose how this job will be performed: On-site, Remote, or Hybrid.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // Job Type Buttons
                jobTypeButton(title: "Onsite Classes", type: "Onsite")
                jobTypeButton(title: "Remote Classes", type: "Remote")
                jobTypeButton(title: "Hybrid Classes", type: "Hybrid")
                
                Spacer()
                
                // Helper Text
                if selectedJobType == nil {
                    Text("Please select a job type to continue")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                
                // Error Message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }
                
                // Navigation Buttons
                HStack {
                    NavigationLink(destination: JobPostTitle1()) {
                        Text("Previous")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                    
                    // ✅ Data pass karte hain next screen ko
                    NavigationLink(destination: JobPostLocation3(
                        jobTitle: jobTitle,
                        jobType: selectedJobType ?? "onsite"
                    )) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(selectedJobType == nil ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
                            .cornerRadius(10)
                    }
                    .disabled(selectedJobType == nil)
                }
                .padding(.top, 10)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
    
    // 🔹 Reusable button component
    private func jobTypeButton(title: String, type: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.black)
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.99, green: 0.97, blue: 0.8))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(selectedJobType == type ? Color.blue : Color.clear, lineWidth: 2)
            )
            .cornerRadius(20)
            .onTapGesture {
                selectedJobType = type
            }
    }
}

#Preview {
    JobPostType2(jobTitle: "Sample Job Title")
}

// ====================================
