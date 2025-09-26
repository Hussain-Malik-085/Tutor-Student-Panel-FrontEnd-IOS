//
//  JobPost4.swift
//  Tutor Panel
//
//  Created by MetaDots on 25/09/2025.
//



import SwiftUI

struct JobPostSkills4: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var fieldSkills: String = ""
    @State private var interests: [String] = []   // Tags list
    
    // ✅ Previous screens se sab data receive karte hain
    let jobTitle: String
    let jobType: String
    let jobLocation: String
    
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
                    Text("4/6")
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10){
                    Text("What are the main skills required for your work?")
                        .font(.headline)
                    
                    Text("Add the key skills you want in a tutor—like subject expertise, teaching ability, or communication skills—to attract the right candidates.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                
          
                
                // Field of Interest with Tags
                VStack(alignment: .leading, spacing: 4) {
                    Text("Add Skills")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                    
                    HStack {
                        TextField("Add Skills", text: $fieldSkills)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        
                        Button(action: {
                            if !fieldSkills.isEmpty {
                                interests.append(fieldSkills)
                                fieldSkills = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .font(.title2)
                        }
                    }
                    
                    // Chips without FlowLayout
                    LazyVStack(alignment: .leading) {
                        ForEach(interests, id: \.self) { interest in
                            Text(interest)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(20)
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                    Spacer()
                    
                    // Navigation buttons
                    HStack {
                        NavigationLink(destination: JobPostLocation3(
                            jobTitle: jobTitle,
                            jobType: jobType)) {
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
                        NavigationLink(destination: JobPostExperience5(
                            jobTitle: jobTitle,
                            jobType: jobType,
                            jobLocation: jobLocation,
                            interests: interests,
                        )) {
                            Text("Next")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(13)
                                .frame(maxWidth: .infinity)
                                .background(interests.isEmpty ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
                                .cornerRadius(10)
                        }
                        .disabled(interests.isEmpty)
                    }
                    .padding(.top, 10)
                }
                .padding()
                .navigationBarHidden(true)
            }
        }
    }
}
#Preview {
    JobPostSkills4(jobTitle: "Sample Job Title", jobType: "onsite", jobLocation: "Sample Location")
}
