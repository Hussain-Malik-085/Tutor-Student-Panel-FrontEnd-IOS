//
//  JobPost3.swift
//  Tutor Panel
//
//  Created by MetaDots on 25/09/2025.
//


import SwiftUI

struct JobPostLocation3: View {
    @Environment(\.dismiss) var dismiss
    @State private var jobLocation: String = ""
    
    // ✅ Previous screens se data receive karte hain
    let jobTitle: String
    let jobType: String
    
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
                    Text("3/6")
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 13){
                    Text("Job Location")
                        .font(.headline)
                    
                    Text("Provide the exact job location or address. A clear location makes it easier for tutors to know where they'll be teaching.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Enter Location", text: $jobLocation)
                    .padding(13)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Spacer()
                
                // Navigation buttons
                HStack {
                    NavigationLink(destination: JobPostType2(jobTitle: jobTitle)) {
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
                    NavigationLink(destination: JobPostSkills4(
                        jobTitle: jobTitle,
                        jobType: jobType,
                        jobLocation: jobLocation
                    )) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(jobLocation.isEmpty ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
                            .cornerRadius(10)
                    }
                    .disabled(jobLocation.isEmpty)
                }
                .padding(.top, 10)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    JobPostLocation3(jobTitle: "Sample Job Title", jobType: "onsite")
}


