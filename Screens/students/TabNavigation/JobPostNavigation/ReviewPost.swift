//
//  ReviewPost.swift
//  Tutor Panel
//
//  Created by MetaDots on 25/09/2025.
//

import SwiftUI

struct ReviewPost: View {
    @Environment(\.dismiss) var dismiss
    //@StateObject var jobPostData = JobPostData()  // shared data model
    
    // ✅ Previous screens se sab data receive karte hain
    let jobTitle: String
    let jobType: String
    let jobLocation: String
    let interests: [String]
    let selectedExperience: String
    let details: String
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Back Button
                VStack {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Review Job Post")
                        }
                    }
                
                }
              
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        
                        
                        // Job Title
                        HStack {
                            Text("Job Title")
                            Spacer()
                            NavigationLink(destination: JobPostTitle1()) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        Text(jobTitle) // <-- Data shown here
                            .font(.subheadline)
                        
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        
                        Divider()
                        
                        
                        
                        
                        // Description
                        HStack {
                            
                            Text("Description")
                               
                            Spacer()
                            NavigationLink(destination: JobPostDescription6(
                                
                                jobTitle: jobTitle,
                                jobType: jobType,
                                jobLocation: jobLocation,
                                interests: interests,
                                selectedExperience: selectedExperience,
                            )) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        .padding(.top, 8)
                        Text(details) // <-- Description ka data
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        Divider()
                        
                        
                        // Job Type
                        HStack {
                            Text("Job Type")
                            Spacer()
                            NavigationLink(destination: JobPostType2(
                                jobTitle: jobTitle
                            )) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        .padding(.top, 8)
                        Text(jobType) // <-- Job type show
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        Divider()
                        
                        
                        // Job Location
                        HStack {
                            Text("Job Location")
                            Spacer()
                            NavigationLink(destination: JobPostLocation3(
                                jobTitle: jobTitle,
                                jobType: jobType
                                
                            )) {
                                Image(systemName: "square.and.pencil")
                            }
                           
                        }
                        .padding(.top, 8)
                        Text(jobLocation) // <-- Job location show
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        
                        Divider()
                        
                        // Job Skills
                        HStack {
                            Text("Job Skills")
                            Spacer()
                            NavigationLink(destination: JobPostSkills4(
                                jobTitle: jobTitle,
                                jobType: jobType,
                                jobLocation: jobLocation,
                            )) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        .padding(.top, 8)
                        // ✅ Har skill ko alag line pe dikhane ke liye
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(interests, id: \.self) { skill in
                                Text("• \(skill)") // bullet point ke sath
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.leading, 1)
                        .padding(.bottom, 8)
                        Divider()
                        
                        // Job Experience
                        HStack {
                            Text("Job Experience")
                            Spacer()
                            NavigationLink(destination: JobPostExperience5(
                                
                                jobTitle: jobTitle,
                                jobType: jobType,
                                jobLocation: jobLocation,
                                interests: interests,
                                
                            )) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        .padding(.top, 8)
                        Text(selectedExperience) // <-- Experience show
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                    }
                }
                 
Spacer()
              
        
        
        
        // Navigation buttons
        HStack {
            NavigationLink(destination: JobPostDescription6(
                jobTitle: jobTitle,
                jobType: jobType,
                jobLocation: jobLocation,
                interests: interests,
                selectedExperience: selectedExperience,
                
            
            )) {
                Text("Previous")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(13)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            }

            // ✅ Sab data pass karte hain next screen ko
            NavigationLink(destination: Navigations())  {
                Text("Review Job Post")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(13)
                    .frame(maxWidth: .infinity)
                    .background(details.isEmpty ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
                    .cornerRadius(10)
            }
            .disabled(details.isEmpty)
            .simultaneousGesture(TapGesture().onEnded { sendJobPostData() })
        }
        .padding(.top, 10)
        
        
    }
    .padding()
    .navigationBarHidden(true)
}
        
    }
    
    
    // MARK: - Send Job Post Data
        func sendJobPostData() {
            guard let url = URL(string: "http://localhost:8020/app/navigation/studentjobpost") else { return }
            guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
            
            let body: [String: Any] = [
                "jobTitle": jobTitle,
                "jobType": jobType,
                "jobLocation": jobLocation,
                "interests": interests.filter { !$0.isEmpty },
                "experience": selectedExperience,
                "details": details
            ]
            
            print("📤 Sending job post:", body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("❌ Error sending job post: \(error.localizedDescription)")
                    return
                }
                
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    DispatchQueue.main.async {
                        print("✅ Job post saved response:", json)
                    }
                }
            }.resume()
        }
    }


#Preview {
    ReviewPost(
        jobTitle: "Sample Job Title",
        jobType: "Onsite",
        jobLocation: "Sample Location",
        interests: ["Sample Skill 1", "Sample Skill 2", "Sample Skill 3"],
        selectedExperience: "1 year",
        details: "i need a tutor eho are expert in programing"
    )
}
