import SwiftUI

struct TeacherProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isExpanded = false
    let teacher: TeacherModel
    
    var body: some View {
        
            NavigationStack {
                
                ZStack(alignment: .topLeading) {
                    
                    // ✅ Full width top image
                    AsyncImage(url: URL(string: teacher.fullImageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)   // pura stretch
                            .frame(height: 280)           // header ki height
                            .clipped()
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 280)
                            .overlay(
                                Image(systemName: "person.crop.square.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.green)
                            )
                    }
                    
                    // ✅ Custom back button overlay
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.6))
                            )
                    }
                    .padding(.leading, 16)
                    .padding(.top, 5)   // status bar ke neeche jagah
                }
                
                VStack(spacing: 20) {
                    ScrollView {
                        // ✅ Small Image + Name + Email + Location
                        HStack(alignment: .top, spacing: 12) {
                            AsyncImage(url: URL(string: teacher.fullImageURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } placeholder: {
                                Image(systemName: "person.crop.square.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.green)
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(teacher.name)
                                    .font(.headline)
                                
                                Text(teacher.email)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.secondary)
                                
                                Text(teacher.location)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.secondary)
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        
                        Divider()
                        
                        // ✅ Baqi detail sections
                        HStack(spacing: 20) {
                            statBox(title: "Education", value: teacher.degree)
                            statBox(title: "Experience", value: teacher.experience)
                            statBox(title: "Phone No", value: teacher.phone)
                        }
                        .padding(.vertical)
                        
                        Divider()
                        
                        sectionHeader(icon: "book", title: "About Me")
                        
                        Text(teacher.introduction)
                            .font(.system(size: 14))
                            .lineLimit(isExpanded ? nil : 4)
                            .truncationMode(.tail)
                            .padding(.horizontal)
                            .onTapGesture {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }
                        
                        Divider()
                        Spacer(minLength: 20)
                       // ✅ Languages
                        HStack(spacing: 11) {
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.gray)
                            
                            
                            Text("Languages I Speak")
                            .font(.system(size: 15))}
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                                
                                ForEach(teacher.language, id: \.self) { lang in
                                    Text(lang)
                                        .font(.system(size: 12, weight: .light))
                                        .padding(.vertical, 2) // 👈 har language k text ke upar/neeche 2pt space
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 12)
                            
                        

                        Divider()
                        
                        sectionHeader(icon: "bag.fill", title: "Education")
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(teacher.degree)
                                .font(.system(size: 13, weight: .medium))
                            Text(teacher.university)
                                .font(.system(size: 13))
                            
                            HStack(spacing: 6) {
                                Text(formatDateString(teacher.startDate))
                                    .font(.system(size: 13, weight: .medium))
                                Text("-")
                                Text(formatDateString(teacher.endDate))
                                    .font(.system(size: 13, weight: .medium))
                            }

                            
                            Text(teacher.specialization)
                                .font(.system(size: 13))
                                .lineLimit(2)
                                .truncationMode(.tail)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.green.opacity(0.15))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                        
                        Spacer(minLength: 40)
                        
                        // ✅ Navigation buttons
                        HStack {
                            NavigationLink(destination: EmptyView()) {
                                Text("Message")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(13)
                                    .frame(maxWidth: .infinity)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                            }
                            
                            NavigationLink(destination: EmptyView()) {
                                Text("Call Now")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(13)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
              
                .navigationBarBackButtonHidden(true) // ✅ default back hata do
                
            }}
       
    
        private func sectionHeader(icon: String, title: String) -> some View {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.gray)
                Text(title)
                    .font(.system(size: 15, weight: .medium))
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        private func statBox(title: String, value: String) -> some View {
            VStack {
                Text(value)
                    .font(.system(size: 13, weight: .medium))
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    
    func formatDateString(_ dateString: String) -> String {
        return dateString.components(separatedBy: "T").first ?? dateString
    }

    
}
