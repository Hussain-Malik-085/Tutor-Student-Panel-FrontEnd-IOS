import SwiftUI

struct CreateProfileDescription: View {
    @Environment(\.dismiss) var dismiss
    @State private var introduction: String = ""
    @State private var teaching: String = ""
    @State private var motivate: String = ""
    @State private var headline: String = ""
    @State private var currentPhase: String = "Description >"
    
    // Dummy states (abhi ke liye UI only)
    @State private var isLoading = false
    @State private var hasExistingData = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                .padding(.bottom, 12)
                
                // Section Title
                Text("Profile Description")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
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
                                        .disableAutocorrection(true) // Disable autocorrect for smooth typing

                                    Text("Total words you typed: \(introduction.split(whereSeparator: { $0.isWhitespace }).count)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                
                    
                        
                        // Teaching Experience
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
                                        .disableAutocorrection(true) // Disable autocorrect for smooth typing

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
                                        .disableAutocorrection(true) // Disable autocorrect for smooth typing

                                    Text("Total words you typed: \(motivate.split(whereSeparator: { $0.isWhitespace }).count)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                        
                        
                        // Motivate
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
                                        .disableAutocorrection(true) // Disable autocorrect for smooth typing

                                    Text("Total words you typed: \(headline.split(whereSeparator: { $0.isWhitespace }).count)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                    }
                    .padding(.bottom, 20)
                }
                
                // Navigation buttons
                HStack {
                    NavigationLink(destination: Text("Previous Screen")) {
                        Text("Previous")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                    
                    Button(action: {
                        alertMessage = "Education saved!"
                        showAlert = true
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
                    .padding(13)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                    .cornerRadius(10)
                }
                .padding(.vertical)
            }
            .padding()
            .navigationBarHidden(true)
            .alert("Education Profile", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    CreateProfileDescription()
}
