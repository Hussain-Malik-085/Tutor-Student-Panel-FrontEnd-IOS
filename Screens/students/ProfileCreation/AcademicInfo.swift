//
//  AcademicInfo.swift
//  Tutor Panel
//
//  Created by MetaDots on 19/09/2025.
//

//
//  BasicInfo.swift
//  Tutor Panel
//
//  Created by MetaDots on 19/09/2025.

import SwiftUI

struct AcademicInfo: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedGrade: String = ""
    @State private var selectedYear: String = ""
    @State private var preferredSubject: String = ""
    @State private var fieldOfInterest: String = ""
    
    @State private var interests: [String] = []   // Tags list
    
    @State private var isLoading: Bool = false
    @State private var navigateToNext = false
    
    let items = [
        "Basic Info  >",
        "Photo  >",
        "Academic Info",
    ]
    
    @State private var currentPhase: String = "Academic Info"
    
    private let grade: [String] = (1...24).map { "\($0)" }
    private let year: [String] = (1990...2040).map { "\($0)" }
    
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
                
                Text("Academic Info")
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
                        
                        // Grade Level
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Grade Level")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                            HStack {
                                Text(selectedGrade.isEmpty ? "E.g. 12th Grade" : selectedGrade)
                                    .foregroundColor(selectedGrade.isEmpty ? .gray : .black)
                                Spacer()
                                Menu {
                                    ForEach(grade, id: \.self) { grade in
                                        Button(action: {
                                            selectedGrade = grade
                                        }) {
                                            Text(grade)
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
                        
                        // Academic Year
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Academic Year")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                            HStack {
                                Text(selectedYear.isEmpty ? "E.g. 2022" : selectedYear)
                                    .foregroundColor(selectedYear.isEmpty ? .gray : .black)
                                Spacer()
                                Menu {
                                    ForEach(year, id: \.self) { grade in
                                        Button(action: {
                                            selectedYear = grade
                                        }) {
                                            Text(grade)
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
                        
                        // Preferred Subject
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Preferred Subject")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                            
                            TextField("E.g. Mathematics", text: $preferredSubject)
                                .padding(13)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        // Field of Interest with Tags
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Field of Interest")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                            
                            HStack {
                                TextField("E.g. English", text: $fieldOfInterest)
                                    .padding(13)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                
                                Button(action: {
                                    if !fieldOfInterest.isEmpty {
                                        interests.append(fieldOfInterest)
                                        fieldOfInterest = ""
                                    }
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.title2)
                                }
                            }
                            
                            // Chips
                            FlowLayout(interests) { interest in
                                Text(interest)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(20)
                            }
                        }
                        
                        
                    Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                      
                        
                    
                        
                    }
                    
                     
                        
                        // Next Button
                        Button(action: {
                            isLoading = true
                            sendProfileData { success in
                                isLoading = false
                                if success {
                                    navigateToNext = true
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
                                destination: CompletingProfileStudent(),
                                isActive: $navigateToNext
                            ) { EmptyView() }
                        )
                        
                    }
                    .padding(.bottom, 20)
                
            }
            .padding()
            .navigationBarHidden(true)
            .onAppear {
                fetchProfileData()
            }
        }
    }
    
    // MARK: - Fetch Profile from Backend
    private func fetchProfileData() {
        guard let url = URL(string: "http://localhost:8020/app/student/getacademicinfo") else { return }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let status = json["status"] as? Int, status == 1,
                   let profileData = json["data"] as? [String: Any] {
                    
                    DispatchQueue.main.async {
                        self.selectedGrade = profileData["Grade"] as? String ?? ""
                        self.selectedYear = profileData["Year"] as? String ?? ""
                        self.preferredSubject = profileData["PrefferedSubjects"] as? String ?? "" // ✅ backend se string aa rahi hai
                        self.interests = profileData["Interests"] as? [String] ?? []
                    }
                }
            } catch {
                print("❌ Error parsing: \(error)")
            }
        }.resume()
    }

    // MARK: - Post Profile to Backend
    private func sendProfileData(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8020/app/student/academicinfo") else { return }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "Grade": selectedGrade,
            "Year": selectedYear,
            "PrefferedSubjects": preferredSubject, // ✅ backend array expect karta hai
            "Interests": interests
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("❌ Error: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("📡 Status Code: \(httpResponse.statusCode)")
                completion(httpResponse.statusCode == 200)
            }
        }.resume()
    }

}

// MARK: - FlowLayout for Tags
struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    private var data: Data
    private var content: (Data.Element) -> Content
    
    init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(Array(data), id: \.self) { item in
                    content(item)
                        .padding(4)
                        .alignmentGuide(.leading) { d in
                            if abs(width - d.width) > geometry.size.width {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if item == data.last {
                                width = 0
                            } else {
                                width -= d.width
                            }
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            if item == data.last {
                                height = 0
                            }
                            return result
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AcademicInfo()
}
