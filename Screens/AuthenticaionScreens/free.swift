//
//import SwiftUI
//
//struct TeacherCard: View {
//    
//    struct Teacher: Identifiable, Codable {
//        let id: String
//        let name: String
//        let location: String
//        let experience: String
//        let degree: String
//        let phone: String
//        let specialization: String
//        let language: String
//    }
//
//    let teacher: Teacher
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text(teacher.name)
//                .font(.headline)
//            
//            Text(teacher.location)
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//            
//            Text("Experience: \(teacher.experience)")
//                .font(.subheadline)
//            
//            Text("Degree: \(teacher.degree)")
//                .font(.subheadline)
//            
//            Text("Specialization: \(teacher.specialization)")
//                .font(.subheadline)
//                .lineLimit(2) // sirf 2 lines dikhaye, click pe details screen dikhana
//            
//            Text("Languages: \(teacher.language)")
//                .font(.subheadline)
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(radius: 4)
//        .padding(.horizontal)
//    }
//}
//#Preview {
//    TeacherCard()
//}
