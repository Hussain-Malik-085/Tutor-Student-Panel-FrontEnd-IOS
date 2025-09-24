//
//  HomeView.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/09/2025.
//

//
//  HomeView.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/09/2025.
//

import SwiftUI

struct HomeView: View {
    @Binding var isDrawerOpen: Bool
    @State private var teachers: [TeacherModel] = []
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                // ✅ Tutors count (fixed at top, not scrolling)
                Text("\(teachers.count) Tutors Available")
                    .font(.caption)
                    .padding(.leading)
                    .padding(.top, 8)
                
                // ✅ Scroll starts from here
                ScrollView {
                    if isLoading {
                        ProgressView("Loading teachers...")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                    } else {
                        VStack(spacing: 20) {
                            ForEach(teachers) { teacher in
                                NavigationLink(destination: TeacherProfileView(teacher: teacher)) {
                                    TeacherCardView(teacher: teacher)
                                        .contentShape(Rectangle()) // ✅ pura card tappable ho jaye
                                }
                                .buttonStyle(PlainButtonStyle()) // ✅ default blue highlight hata dega
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Explore Teachers")
                        .font(.system(size: 24))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            isDrawerOpen.toggle()
                        }
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.title)
                            .foregroundColor(.green) 
                    }
                }
            }
            .onAppear {
                fetchTeachers()
            }
        }
    }
    
    private func fetchTeachers() {
        guard let url = URL(string: "http://localhost:8020/app/navigation/tutorcardprofile") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedTeachers = try JSONDecoder().decode([TeacherModel].self, from: data)
                    DispatchQueue.main.async {
                        self.teachers = decodedTeachers
                        self.isLoading = false
                    }
                } catch {
                    print("❌ JSON Decode Error:", error)
                }
            }
        }.resume()
    }
}
