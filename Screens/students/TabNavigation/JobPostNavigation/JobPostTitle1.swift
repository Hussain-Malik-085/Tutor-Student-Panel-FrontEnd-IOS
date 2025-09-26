//
//   JobPostView.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/09/2025.
//

import SwiftUI

struct JobPostTitle1: View {
    @Environment(\.dismiss) var dismiss
  /*  @ObservedObject var jobPostData: JobPostData */  // shared reference
    @State private var jobTitle: String = ""
    
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
                    Text("1/6")
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .leading){
                    Text("Let's Start with a Strong Title")
                        .font(.headline)
                    
                    Text("Your job post starts here! A clear and catchy title helps the right tutor find your opportunity. Make it stand out, and attract the talent you're looking for.")
                        .font(.caption)
                    
                    Text("Job Title")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("E.g. Native English Teacher", text: $jobTitle)
                    .padding(13)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Spacer()
                
                // Next Button - data ko next screen pe pass karte hain
                NavigationLink(destination: JobPostType2(jobTitle: jobTitle)) {
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(jobTitle.isEmpty ? Color.gray : Color(red: 12/255, green: 144/255, blue: 121/255))
                        .cornerRadius(10)
                }
                .disabled(jobTitle.isEmpty)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    JobPostTitle1()
}
