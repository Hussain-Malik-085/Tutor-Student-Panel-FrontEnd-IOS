//
//  CreateProfile-Education.swift
//  Tutor Panel
//
//  Created by MetaDots on 25/08/2025.
//
//
//  Aboutus.swift
//  Tutor Panel
//
//  Created by MetaDots on 25/08/2025.
//
import SwiftUI

struct CreateProfileEducation: View {
    @Environment(\.dismiss) var dismiss   // back action ke liye
    @State private var selectedRole: String? = nil
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var showError: Bool = false
    @State private var phonenumber: String = ""
    @State private var experience: String = ""
    @State private var country: String = ""
    @State private var selectedCountry: String = "Pakistan"
    @State private var location: String = ""
    @State private var language: String = ""
    @State private var subject: String = ""
    @State private var currentPhase: String = "Education  >"   // default phase
    
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    
    @State private var showDatePicker1 = false
    @State private var selectedDate1 = Date()
    
    let items = [
        "About Us  >",
        "Photo  >",
        "Certification  >",
        "Education  >",
        "Skills  >",
        "Description  >",
        "Availability  >",
        "ID Card Verification "
    ]
    
    let countries: [String] = Locale.Region.isoRegions.compactMap { region in
        Locale.current.localizedString(forRegionCode: region.identifier)
    }.sorted()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()  // is se pichli screen pe wapis chale jao
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                            Text("Create Your Profile")
                                .foregroundColor(.black)
                        }
                    }
                    Spacer()
                }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(items, id: \.self) { item in
                            Text(item)
                                .font(.caption)
                                .foregroundColor(item == currentPhase ? .red : .black) // 🔴 current wala red
                                .fontWeight(item == currentPhase ? .bold : .regular) // current ko bold bhi kar diya
                            
                        }
                    }
                }
                
                Text("Education")
                    .font(.headline)
                
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text("orem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .font(.caption)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                ScrollView {
                    Text("University")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    TextField("E.g. Mount Royal University", text: $username)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                    
                    Text("Degree")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    TextField("E.g. Bachelor’s in English language", text: $username)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                        .padding(.bottom,9)
                    
                    HStack{
                        Text("Start Date")
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("End Date")
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                        
                    
                    
                    HStack{
                        
                        
                        // Button style rectangle
                                  Button(action: {
                                      showDatePicker = true
                                  }) {
                                      Text(selectedDate.formatted(date: .long, time: .omitted)) // yahan selected date dikhegi
                                          .font(.headline)
                                          .foregroundColor(.black)
                                          .padding(13)
                                          .frame(maxWidth: .infinity)
                                          .background(Color.white)
                                          .cornerRadius(10)
                                          .overlay(
                                              RoundedRectangle(cornerRadius: 10)
                                                  .stroke(Color.black, lineWidth: 1)   // black border
                                          )
                                  }
                                  .padding(.vertical)
                                  .sheet(isPresented: $showDatePicker) {  // date picker sheet
                                      VStack {
                                          DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                                              .datePickerStyle(.graphical)
                                              .padding()
                                          
                                          Button("Done") {
                                              showDatePicker = false
                                          }
                                          .padding()
                                          .background(Color.blue.opacity(0.7))
                                          .foregroundColor(.white)
                                          .cornerRadius(10)
                                      }
                                      .padding()
                                  }
                        
                        
                        // Button style rectangle
                                  Button(action: {
                                      showDatePicker1 = true
                                  }) {
                                      Text(selectedDate1.formatted(date: .long, time: .omitted)) // yahan selected date dikhegi
                                          .font(.headline)
                                          .foregroundColor(.black)
                                          .padding(13)
                                          .frame(maxWidth: .infinity)
                                          .background(Color.white)
                                          .cornerRadius(10)
                                          .overlay(
                                              RoundedRectangle(cornerRadius: 10)
                                                  .stroke(Color.black, lineWidth: 1)   // black border
                                          )
                                  }
                                  .padding(.vertical)
                                  .sheet(isPresented: $showDatePicker1) {  // date picker sheet
                                      VStack {
                                          DatePicker("Select a Date", selection: $selectedDate1, displayedComponents: .date)
                                              .datePickerStyle(.graphical)
                                              .padding()
                                          
                                          Button("Done") {
                                              showDatePicker1 = false
                                          }
                                          .padding()
                                          .background(Color.blue.opacity(0.7))
                                          .foregroundColor(.white)
                                          .cornerRadius(10)
                                      }
                                      .padding()
                                  }
                    }
                    
                    
                    
                    
                    Text("Introduction")
                        .font(.headline)
                    
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                           
                    Text("Introduce YourSelf")
                        .padding(.top)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    TextField("E.g. 5 Years", text: $experience)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                    
                    
                    
                    // Country label (as-is)
                    Text("Country")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Countries list (iOS 16+ safe)
                    let countries = Locale.Region.isoRegions.compactMap { region in
                        Locale.current.localizedString(forRegionCode: region.identifier)
                    }.sorted()

                    // TextField with trailing picker (overlay)
                    TextField("E.g. Pakistan", text: $country)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        // optional: right padding taake text icon ke neeche na aaye
                        .padding(.trailing, 28)
                        .overlay(alignment: .trailing) {
                            Menu {
                                ForEach(countries, id: \.self) { name in
                                    Button(name) { country = name }
                                }
                            } label: {
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                        .padding(.vertical, 2)

                    
                    
                    
                    Text("Location")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    TextField("E.g. Model town lahore", text: $location)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                    
                    Text("Language Spoken")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    TextField("E.g. English", text: $language)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                    
                    Text("Subject Taught")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    TextField("E.g. Model town lahore", text: $subject)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                    
                    Spacer()
                    
                    NavigationLink(destination: CreateProfilePicture()) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                            .cornerRadius(10)
                            .padding(.vertical)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        print("Next button pressed")
                    })
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
                
                .padding()
                
                .navigationBarHidden(true)
                
            }
    }
    
    
}
//
#Preview {
    CreateProfileEducation()
}

//  Splash.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/08/2025.
//




