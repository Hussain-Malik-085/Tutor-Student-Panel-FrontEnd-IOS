//
//  JobPost6.swift
//  Tutor Panel
//
//  Created by MetaDots on 25/09/2025.
//

import SwiftUI

struct JobPostDescription6: View {
    @Environment(\.dismiss) var dismiss
    @State private var details: String = ""
    // ✅ Previous screens se sab data receive karte hain
    let jobTitle: String
    let jobType: String
    let jobLocation: String
    let interests: [String]
    let selectedExperience: String
    
    var body: some View {
        NavigationStack {
            VStack {
                // Back Button
                HStack {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Post a Job")
                        }
                    }
                    Spacer()
                    Text("6/6")
                }
               
                
                
                VStack(alignment: .leading){
                    Text("Describe What You Need")
                        .font(.headline)
                    
                    Text("Provide a clear description of the job so tutors know your exact requirements and expectations.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity , alignment: .leading)
                .padding(.vertical)
                
                TextEditor(text: $details)
                    .frame(height: 180)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .disableAutocorrection(true)
                
                Text("Total words you typed: \(details.split(whereSeparator: { $0.isWhitespace }).count)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
            
               Spacer()
                // Navigation buttons
                HStack {
                    NavigationLink(destination: JobPostExperience5(
                        jobTitle: jobTitle,
                        jobType: jobType,
                        jobLocation: jobLocation,
                        interests: interests,
                        
                    
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
                    NavigationLink(destination: ReviewPost(
                        jobTitle: jobTitle,
                        jobType: jobType,
                        jobLocation: jobLocation,
                        interests: interests,
                        selectedExperience: selectedExperience,
                        details: details,
                    )) {
                        Text("Review Job Post")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(details.isEmpty ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
                            .cornerRadius(10)
                    }
                    .disabled(details.isEmpty)
                }
                .padding(.top, 10)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    JobPostDescription6(
        jobTitle: "Sample Job Title",
        jobType: "Onsite",
        jobLocation: "Sample Location",
        interests: ["Sample Skill 1", "Sample Skill 2", "Sample Skill 3"],
        selectedExperience: "1 year"
    )
}
