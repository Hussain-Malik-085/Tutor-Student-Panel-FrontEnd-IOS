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
    @State private var teachers: [TeacherCard] = []
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                if isLoading {
                    ProgressView("Loading teachers...")
                } else {
                    VStack(spacing: 20) {
                        ForEach(teachers) { teacher in
                            
                            TeacherCardView(teacher: teacher)
                        }
                    }
                    .padding(.top)
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
                    }
                }
            }
            .onAppear {
                fetchTeachers()
            }
        }
    }
    
    private func fetchTeachers() {
        guard let url = URL(string: "http://localhost:8020/app/navigation/tutorcard") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedTeachers = try JSONDecoder().decode([TeacherCard].self, from: data)
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
