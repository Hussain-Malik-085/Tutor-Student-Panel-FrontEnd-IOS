import SwiftUI

struct CreateProfileAboutUS: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var showError: Bool = false
    @State private var phonenumber: String = ""
    @State private var experience: String = ""
    @State private var country: String = "Pakistan"
    @State private var location: String = ""
    @State private var language: String = ""
    @State private var subject: String = ""
    @State private var currentPhase: String = "About Us  >"
    
    let items = [
        "About Us  >", "Photo  >", "Certification  >", "Education  >",
        "Skills  >", "Description  >", "Availability  >", "ID Card Verification "
    ]
    
    var countries: [String] {
        Locale.Region.isoRegions.compactMap { region in
            Locale.current.localizedString(forRegionCode: region.identifier)
        }.sorted()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Back Button
                HStack {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Create Your Profile")
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 10)
                
                // Horizontal Phase Scroll
                ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(items, id: \.self) { item in
                                    Text(item)
                                        .font(.caption)
                                        .foregroundColor(item == currentPhase ? .red : .black)
                                        .fontWeight(item == currentPhase ? .bold : .regular)
                                        .id(item) // 👈 har item ki id
                                }
                            }
                        }
                        .onChange(of: currentPhase) { oldValue,newValue in
                            withAnimation {
                                proxy.scrollTo(newValue, anchor: .leading) // 👈 leading use karo
                            }
                        }
                        .onAppear {
                            // jab view first time load ho to bhi currentPhase ko scroll karo
                            proxy.scrollTo(currentPhase, anchor: .leading)
                        }
                    }
                
                Text("About Us")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        // Username
                        VStack(alignment: .leading, spacing: 2) {
                            Text("User Name (Can't be changed)")
                                .font(.system(size: 12))
                                .foregroundColor(.red)
                            TextField("E.g. Steve Smith", text: $username)
                                .padding(13)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .disabled(true) // username can't be changed
                        }
                        
                        // Email
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Email (Can't be changed)")
                                .font(.system(size: 12))
                                .foregroundColor(.red)
                            TextField("Enter your Email Address", text: $email)
                                .padding(13)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .disabled(true)
                        }
                        
                        // Phone
                        TextField("Phone Number", text: $phonenumber)
                            .keyboardType(.numberPad)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .onChange(of: phonenumber) { _, newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                phonenumber = String(filtered.prefix(11))
                            }
                        
                        // Experience
                        TextField("Experience", text: $experience)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        
                        // Country
                        TextField("Country", text: $country)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(alignment: .trailing) {
                                Menu {
                                    ForEach(countries, id: \.self) { name in
                                        Button(name) { country = name }
                                    }
                                } label: {
                                    Image(systemName: "chevron.down")
                                        .padding(.trailing, 8)
                                }
                            }
                        
                        // Location
                        TextField("Location", text: $location)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        
                        // Language
                        TextField("Language", text: $language)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        
                        // Subject
                        TextField("Subject", text: $subject)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        
                        Spacer()
                        
                        // Next Button
                        NavigationLink(destination: CreateProfilePicture()) {
                            Text("Next")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                                .cornerRadius(10)
                        }
                        .simultaneousGesture(TapGesture().onEnded { sendProfileData() })
                        
                    }
                    .padding(.bottom, 20)
                }
            }
            .padding()
            .navigationBarHidden(true)
            .onAppear {
                loadSavedUserData()
                fetchProfileData()
            }
        }
    }
    
    // MARK: - Load saved username/email
    func loadSavedUserData() {
        if let savedUsername = UserDefaults.standard.string(forKey: "Username") { username = savedUsername }
        if let savedEmail = UserDefaults.standard.string(forKey: "Email") { email = savedEmail }
    }
    
    // MARK: - Fetch Profile
    func fetchProfileData() {
        guard let url = URL(string: "http://localhost:8020/app/tutor/getprofile") else { return }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
        
        print("📱 Fetching profile with token: \(token)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Error fetching profile: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("❌ No data received from server")
                return
            }
            
            // Debug raw response
            if let responseString = String(data: data, encoding: .utf8) {
                print("📱 Raw profile response: \(responseString)")
            }
            
            // Parse JSON
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print("📱 Parsed JSON from backend:", json)
                
                // Check if we have data field in response
                let profileData = json["data"] as? [String: Any] ?? json
                print("📱 Profile data to process:", profileData)
                
                DispatchQueue.main.async {
                    // Update fields with proper handling
                    let newPhone = profileData["Phone"] as? String ?? ""
                    let newExperience = profileData["Experience"] as? String ?? ""
                    let newCountry = profileData["Country"] as? String ?? "Pakistan"
                    let newLocation = profileData["Location"] as? String ?? ""
                    
                    // Handle Language array - get first non-empty value
                    var newLanguage = ""
                    if let languageArray = profileData["Language"] as? [String] {
                        newLanguage = languageArray.first(where: { !$0.isEmpty }) ?? ""
                    }
                    
                    // Handle Subject array - get first non-empty value
                    var newSubject = ""
                    if let subjectArray = profileData["Subject"] as? [String] {
                        newSubject = subjectArray.first(where: { !$0.isEmpty }) ?? ""
                    }
                    
                    // Update state variables
                    phonenumber = newPhone
                    experience = newExperience
                    country = newCountry
                    location = newLocation
                    language = newLanguage
                    subject = newSubject
                    
                    print("📱 Updated UI fields:")
                    print("Phone: '\(phonenumber)'")
                    print("Experience: '\(experience)'")
                    print("Country: '\(country)'")
                    print("Location: '\(location)'")
                    print("Language: '\(language)'")
                    print("Subject: '\(subject)'")
                }
            } else {
                print("❌ Failed to parse JSON response")
            }
        }.resume()
    }
    
    // MARK: - Send Profile Data
    func sendProfileData() {
        guard let url = URL(string: "http://localhost:8020/app/tutor/createprofileaboutus") else { return }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
        
        let body: [String: Any] = [
            "Phone": phonenumber,
            "Experience": experience,
            "Country": country,
            "Location": location,
            "Language": [language].filter { !$0.isEmpty }, // Empty strings remove karo
            "Subject": [subject].filter { !$0.isEmpty }    // Empty strings remove karo
        ]
        
        print("📱 Sending profile data:", body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("❌ Error sending profile: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                DispatchQueue.main.async {
                    print("✅ Profile saved response: \(json)")
                }
            }
        }.resume()
    }
}

#Preview {
    CreateProfileAboutUS()
}
