//
//  Aboutus.swift
//  Tutor Panel
//
//  Created by MetaDots on 25/08/2025.
//
import SwiftUI

struct CreateProfileAboutUS: View {
    @Environment(\.dismiss) var dismiss   // back action ke liye
    @State private var selectedRole: String? = nil
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var showError: Bool = false
    @State private var phonenumber: String = ""
    @State private var experience: String = ""
    @State private var country: String = "Pakistan"
    
    @State private var location: String = ""
    @State private var language: String = ""
    @State private var subject: String = ""
    @State private var currentPhase: String = "About Us  >"   // default phase
    
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
                
                // 👇 ye onAppear lagao
                       .onAppear {
                           if let savedUsername = UserDefaults.standard.string(forKey: "Username") {
                               username = savedUsername
                           }
                           if let savedEmail = UserDefaults.standard.string(forKey: "Email") {
                               email = savedEmail
                           }
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
                    
                    Text("About Us")
                        .font(.headline)
                    
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom,2)
                    
                ScrollView {
                    HStack(spacing: 4) {   
                        Text("User Name")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                        
                        Text("(User Name Can't be changed)")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                            .italic()
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)


                    
                    TextField("E.g. Steve Smith", text: $username)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                    
                    
                    
                    HStack(spacing: 4) {
                        Text("Email Address")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                        
                        Text("(Email Can't be changed)")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                            .italic()
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    
                    TextField("Enter your Email Address", text: $email)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                        .onChange(of: email) { _, newValue in
                                            // check if email contains "@"
                                            if newValue.contains("@") {
                                                showError = false
                                            } else {
                                                showError = true
                                            }
                                        }
                                    
                                    if showError && !email.isEmpty {
                                        Text("⚠️ Email must contain @ symbol")
                                            .foregroundColor(.red)
                                            .font(.caption)
                                    }
                    
                    
                    Text("Phone Number")
                                   .font(.system(size: 12))
                                   .fontWeight(.medium)
                                   .frame(maxWidth: .infinity, alignment: .leading)
                               
                    TextField("E.g. 03056789888", text: $phonenumber)
                        .keyboardType(.numberPad)
                        .padding(13)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical,2)
                        .onChange(of: phonenumber) { _, newValue in
                            // Sirf digits allow karo
                            let filtered = newValue.filter { $0.isNumber }
                            // Max 11 digits tak hi rakho
                            if filtered.count > 11 {
                                phonenumber = String(filtered.prefix(11))
                            } else {
                                phonenumber = filtered
                            }
                        }
                           
                    Text("Experience")
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
                        sendProfileData()
                    })
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
                
                .padding()
                
                .navigationBarHidden(true)
                
            }
    }
    
    func sendProfileData() {
        guard let url = URL(string: "http://localhost:8020/app/CreateProfileAboutUs") else { return }
        
        // jo values tum state me rakhe ho unko JSON me bhejna hoga
        let body: [String: Any] = [
            "Phone": phonenumber,
            "Experience": experience,
            "Country": country,
            "Location": location,
            "Language": [language], // array bhejna hai
            "Subject": [subject]    // array bhejna hai
        ]
        
        // JWT token storage (login ke baad secure store me save karna hoga)
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // ✅ yahan token bhejna

        
        // body ko JSON me convert karo
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                DispatchQueue.main.async {
                    print("✅ Response: \(json)")
                    // Yahan success alert ya next screen navigation
                }
            }

        }.resume()
    }

}
//
#Preview {
    CreateProfileAboutUS()
}

//  Splash.swift
//  Tutor Panel
//
//  Created by MetaDots on 22/08/2025.
//



