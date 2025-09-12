import SwiftUI

struct DaySelectionView: View {
    @State private var selectedDays: Set<String> = []  // store selected days
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Select Days")
                .font(.title2)
                .bold()
            
            ForEach(days, id: \.self) { day in
                HStack {
                    Button(action: {
                        if selectedDays.contains(day) {
                            selectedDays.remove(day)   // untick
                        } else {
                            selectedDays.insert(day)   // tick
                        }
                    }) {
                        Image(systemName: selectedDays.contains(day) ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                    Text(day)
                        .font(.title2)
                }
            }
            
//            Divider()
            
//            // Select All Button
//            Button(action: {
//                if selectedDays.count == days.count {
//                    selectedDays.removeAll() // sab clear
//                } else {
//                    selectedDays = Set(days) // sab select
//                }
//            }) {
//                HStack {
//                    Image(systemName: selectedDays.count == days.count ? "checkmark.square.fill" : "square")
//                        .foregroundColor(.green)
//                        .font(.title2)
//                    Text("Select All")
//                        .bold()
//                }
//            }
//            
//            // Debug selected days
//            Text("Selected: \(selectedDays.joined(separator: ", "))")
//                .foregroundColor(.gray)
//                .padding(.top, 10)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DaySelectionView()
}
