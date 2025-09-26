//
//  JobPost5.swift
//  Tutor Panel
//
//  Created by MetaDots on 25/09/2025.


import SwiftUI

struct JobPostExperience5: View {
    @Environment(\.dismiss) var dismiss
  
   
    @State private var selectedExperience: String = ""

    
    @State private var currentPhase: String = "Basic Info  >"
    private let ExperienceYears: [String] = (0...40).map { "\($0)" }
  
    
    // ✅ Previous screens se sab data receive karte hain
    let jobTitle: String
    let jobType: String
    let jobLocation: String
    let interests: [String]

    
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
                    Text("5/6")
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Job Experience")
                        .font(.headline)
                    
                    Text("Specify the level of teaching experience you expect from the tutor.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity , alignment: .leading)
                .padding(.vertical)
                
            
                
            
                
                // Age
                VStack(alignment: .leading, spacing: 4) {
                    Text("Experience Years")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                    HStack {
                        Text(selectedExperience.isEmpty ? "E.g. 4 Years" : selectedExperience)
                            .foregroundColor(selectedExperience.isEmpty ? .gray : .black)
                        Spacer()
                        Menu {
                            ForEach(ExperienceYears, id: \.self) { years in
                                Button(action: {
                                    selectedExperience = years
                                }) {
                                    Text(years)
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
                Spacer()
                
                // Navigation buttons
                HStack {
                    NavigationLink(destination: JobPostSkills4(
                        jobTitle: jobTitle,
                        jobType: jobType,
                        jobLocation: jobLocation,
                        
                    
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
                    NavigationLink(destination: JobPostDescription6(
                        jobTitle: jobTitle,
                        jobType: jobType,
                        jobLocation: jobLocation,
                        interests: interests,
                        selectedExperience: selectedExperience,
                    )) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(selectedExperience.isEmpty ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
                            .cornerRadius(10)
                    }
                    .disabled(selectedExperience.isEmpty)
                }
                .padding(.top, 10)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}
#Preview {
    JobPostExperience5(
        jobTitle: "Sample Job Title",
        jobType: "Onsite",
        jobLocation: "Sample Location",
        interests: ["Sample Skill 1", "Sample Skill 2", "Sample Skill 3"] // 👈 array of strings
    )
}
