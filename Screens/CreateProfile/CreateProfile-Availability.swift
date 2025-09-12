//
//  CreateProfile-Availability.swift
//  Tutor Panel
//
//  Created by MetaDots on 12/09/2025.
//

import SwiftUI

// Time slot model
struct TimeSlot: Identifiable, Equatable {
    let id = UUID()
    var fromTime: String = "10:00 PM"
    var toTime: String = "11:00 PM"
}

// Day availability model
struct DayAvailability: Identifiable {
    let id = UUID()
    let dayName: String
    var isAvailable: Bool = false
    var timeSlots: [TimeSlot] = [TimeSlot()]
}

struct CreateProfileAvailability: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var currentPhase: String = "Availability >"
    
    // Loading states
    @State private var isLoading = false
    @State private var hasExistingData = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // Availability data
    @State private var weekDays: [DayAvailability] = [
        DayAvailability(dayName: "Monday"),
        DayAvailability(dayName: "Tuesday"),
        DayAvailability(dayName: "Wednesday"),
        DayAvailability(dayName: "Thursday", isAvailable: false), // Not Available by default
        DayAvailability(dayName: "Friday"),
        DayAvailability(dayName: "Saturday"),
        DayAvailability(dayName: "Sunday")
    ]
    
    let items = [
        "About Us >", "Photo >", "Certification >", "Education >",
        "Skills >", "Description >", "Availability >", "ID Card Verification "
    ]
    
    // Time options for dropdowns
    let timeOptions = [
        "12:00 AM", "12:30 AM", "1:00 AM", "1:30 AM", "2:00 AM", "2:30 AM",
        "3:00 AM", "3:30 AM", "4:00 AM", "4:30 AM", "5:00 AM", "5:30 AM",
        "6:00 AM", "6:30 AM", "7:00 AM", "7:30 AM", "8:00 AM", "8:30 AM",
        "9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM",
        "12:00 PM", "12:30 PM", "1:00 PM", "1:30 PM", "2:00 PM", "2:30 PM",
        "3:00 PM", "3:30 PM", "4:00 PM", "4:30 PM", "5:00 PM", "5:30 PM",
        "6:00 PM", "6:30 PM", "7:00 PM", "7:30 PM", "8:00 PM", "8:30 PM",
        "9:00 PM", "9:30 PM", "10:00 PM", "10:30 PM", "11:00 PM", "11:30 PM"
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
                Text("Set Your Availability")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .font(.caption)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                
                // MARK: ScrollView with Days
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0..<weekDays.count, id: \.self) { dayIndex in
                            DayAvailabilityView(
                                day: $weekDays[dayIndex],
                                timeOptions: timeOptions,
                                onAddTimeSlot: {
                                    addTimeSlot(for: dayIndex)
                                },
                                onRemoveTimeSlot: { slotIndex in
                                    removeTimeSlot(for: dayIndex, at: slotIndex)
                                }
                            )
                        }
                    }
                }
                .frame(maxHeight: 400)
                
                Spacer()
                
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
                    
                    Button(action: saveAvailability) {
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
            .alert("Availability", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func addTimeSlot(for dayIndex: Int) {
        weekDays[dayIndex].timeSlots.append(TimeSlot())
    }
    
    private func removeTimeSlot(for dayIndex: Int, at slotIndex: Int) {
        if weekDays[dayIndex].timeSlots.count > 1 {
            weekDays[dayIndex].timeSlots.remove(at: slotIndex)
        }
    }
    
    private func saveAvailability() {
        isLoading = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoading = false
            alertMessage = "Availability saved successfully!"
            showAlert = true
            
            // Print saved data for debugging
            printAvailabilityData()
        }
    }
    
    private func printAvailabilityData() {
        for day in weekDays {
            print("\(day.dayName): Available = \(day.isAvailable)")
            if day.isAvailable {
                for (index, slot) in day.timeSlots.enumerated() {
                    print("  Slot \(index + 1): \(slot.fromTime) - \(slot.toTime)")
                }
            }
        }
    }
}

// MARK: - Day Availability View
struct DayAvailabilityView: View {
    @Binding var day: DayAvailability
    let timeOptions: [String]
    let onAddTimeSlot: () -> Void
    let onRemoveTimeSlot: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Day header with checkbox
            HStack {
                Button(action: {
                    day.isAvailable.toggle()
                    if day.isAvailable && day.timeSlots.isEmpty {
                        day.timeSlots.append(TimeSlot())
                    }
                }) {
                    HStack {
                        Image(systemName: day.isAvailable ? "checkmark.square.fill" : "square")
                            .foregroundColor(day.isAvailable ? .blue : .gray)
                        
                        Text(day.dayName)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        
                        if !day.isAvailable && day.dayName == "Thursday" {
                            Text("(Not Available)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 4)
            
            // Time slots (only show if available)
            if day.isAvailable {
                ForEach(0..<day.timeSlots.count, id: \.self) { slotIndex in
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("From")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Menu {
                                ForEach(timeOptions, id: \.self) { time in
                                    Button(time) {
                                        day.timeSlots[slotIndex].fromTime = time
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(day.timeSlots[slotIndex].fromTime)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(6)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("To")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Menu {
                                ForEach(timeOptions, id: \.self) { time in
                                    Button(time) {
                                        day.timeSlots[slotIndex].toTime = time
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(day.timeSlots[slotIndex].toTime)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(6)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.leading, 20)
                }
                
                // Add another timeslot button
                HStack {
                    Spacer()
                    Button(action: onAddTimeSlot) {
                        Text("Add another timeslot")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.leading, 20)
                .padding(.top, 4)
            }
            
            // Divider
            Divider()
                .padding(.vertical, 4)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CreateProfileAvailability()
}
