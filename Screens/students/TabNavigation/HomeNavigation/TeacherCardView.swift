//
//  TeacherCard.swift
//  Tutor Panel
//
//  Created by MetaDots on 23/09/2025.
//

import SwiftUI

struct TeacherCardView: View {
    let teacher: TeacherModel
    @State private var isFavorite = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top) {
                // ✅ Async Image for profile
                
                AsyncImage(url: URL(string: teacher.fullImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                } placeholder: {
                    Image(systemName: "person.crop.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                }

                
                
                
                VStack(alignment: .leading, spacing: 1) {
                    HStack {
                        Text(teacher.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: {
                            isFavorite.toggle()
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .red : .gray)
                        }
                    }
                    
                    Text(teacher.location)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text(teacher.experience)
                                .font(.system(size: 11))
                            Text("Experience")
                                .font(.system(size: 11, weight: .light))
                        }
                        VStack(alignment: .leading) {
                            Text(teacher.degree)
                                .font(.system(size: 11))
                            Text("Education")
                                .font(.system(size: 11, weight: .light))
                        }
                        VStack(alignment: .leading) {
                            Text(teacher.phone)
                                .font(.system(size: 11))
                            Text("Phone No")
                                .font(.system(size: 11, weight: .light))
                        }
                    }
                    .padding(.vertical)
                }
            }
            
            Text(teacher.specialization)
                .font(.system(size: 13))
                .lineLimit(2)
                .truncationMode(.tail)
            
            HStack(spacing: 4) {
                Image(systemName: "globe")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("Languages: \(teacher.language.joined(separator: ", "))")
                    .font(.system(size: 12, weight: .light))
            }
        }
        .padding()
        .frame(height: 190)
        .background(Color.gray.opacity(20/100))
        .cornerRadius(13)
        .shadow(radius: 6)
        .padding(.horizontal)
    }
}



//#Preview {
//    TeacherCardView(
//        teacher: TeacherModel(
//            id: "",
//            name: "Ali Raza",
//            email: "abc@gmail.com",
//            introduction: "Hello, I am a passionate and experienced English teacher with a strong background in curriculum development and assessment. I have over 5 years of experience in designing and delivering engaging and effective English language programs for students of all ages and abilities.",
//            university: "University of Peshawar",
//            location: "Lahore",
//            experience: "5 years",
//            degree: "MSc Computer Science",
//            phone: "0300-1234567",
//            specialization: "TEFL Certified English Teacher With 5 Years Experience TEFL Certified English Teacher With 5 Years Experience",
//            startDate: "01-09-2021",
//            endDate: "01-07-2025" ,
//            language: ["English", "Urdu","Hindi"],
//            picture: nil
//        )
//    )
//}
