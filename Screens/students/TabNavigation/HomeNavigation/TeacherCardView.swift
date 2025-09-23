//
//  TeacherCard.swift
//  Tutor Panel
//
//  Created by MetaDots on 23/09/2025.
//

import SwiftUI

struct TeacherCardView: View {
    let teacher: TeacherCard
    @State private var isFavorite = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top) {
                // ✅ Async Image for profile
//                // Image agar backend se aaye to uska URL use hoga
//                Image(systemName: "person.crop.square.fill") .resizable() .frame(width: 80, height: 80) .clipShape(Circle()) .padding(.bottom, 5)
                
                AsyncImage(url: URL(string: teacher.fullImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    Image(systemName: "person.crop.square.fill")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.green)
                }

                
                
                
                VStack(alignment: .leading, spacing: 4) {
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
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 15) {
                        VStack(alignment: .leading) {
                            Text(teacher.experience)
                                .font(.system(size: 12))
                            Text("Experience")
                                .font(.system(size: 12, weight: .light))
                        }
                        VStack(alignment: .leading) {
                            Text(teacher.degree)   // ✅ degree instead of education
                                .font(.system(size: 12))
                            Text("Education")
                                .font(.system(size: 12, weight: .light))
                        }
                        VStack(alignment: .leading) {
                            Text(teacher.phone)
                                .font(.system(size: 12))
                            Text("Phone No")
                                .font(.system(size: 12, weight: .light))
                        }
                    }
                    .padding(.top, 4)
                }
            }
            
            Text(teacher.specialization)
                .font(.system(size: 13))
                .lineLimit(2)
                .truncationMode(.tail)
            
            Text("Language: \(teacher.language.joined(separator: ", "))") .font(.system(size: 12, weight: .light))
        }
        .padding()
        .frame(height: 180)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}
