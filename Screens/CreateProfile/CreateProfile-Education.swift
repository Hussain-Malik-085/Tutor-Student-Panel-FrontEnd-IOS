import SwiftUI
import PhotosUI

struct CreateProfileEducation: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedRole: String? = nil
    @State private var university: String = ""
    @State private var degree: String = ""
    @State private var specialization: String = ""
    @State private var currentPhase: String = "Education >"
    @State private var selectedImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var showStartPicker = false
    @State private var showEndPicker = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    // API ke liye states
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var certificateUrl = ""
    
    let items = [
        "About Us >", "Photo >", "Certification >", "Education >",
        "Skills >", "Description >", "Availability >", "ID Card Verification "
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
                
                // Education title aur description
                Text("Education")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Please provide your educational background details")
                    .font(.caption)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // ScrollView with content
                ScrollView {
                    VStack {
                        // University
                        Text("University")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("E.g. Mount Royal University", text: $university)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.vertical, 2)
                        
                        // Degree
                        Text("Degree")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("E.g. Bachelor's in English language", text: $degree)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.vertical, 2)
                            .padding(.bottom, 9)
                        
                        // Specialization
                        Text("Specialization")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("E.g. Teaching English as a Foreign language", text: $specialization)
                            .padding(13)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.vertical, 2)
                            .padding(.bottom, 9)
                        
                        // Date Picker
                        HStack(spacing: 15) {
                            // Start Date Button
                            Button(action: { showStartPicker = true }) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Start Date")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text(startDate.formatted(.dateTime.day().month(.abbreviated).year()))
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .minimumScaleFactor(0.4)
                                            .scaledToFit()
                                    }
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(.green)
                                }
                                .padding()
                                .frame(minHeight: 50)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)
                            }
                            .sheet(isPresented: $showStartPicker) {
                                VStack {
                                    DatePicker("Select Start Date", selection: $startDate, displayedComponents: .date)
                                        .datePickerStyle(.graphical)
                                        .tint(.green)
                                        .padding()
                                    
                                    Button("Done") {
                                        showStartPicker = false
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                                }
                                .padding()
                                .presentationDetents([.medium, .large])
                            }
                            
                            // End Date Button
                            Button(action: { showEndPicker = true }) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("End Date")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text(endDate.formatted(.dateTime.day().month(.abbreviated).year()))
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .minimumScaleFactor(0.6)
                                            .scaledToFit()
                                    }
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(.green)
                                }
                                .padding()
                                .frame(minHeight: 50)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)
                            }
                            .sheet(isPresented: $showEndPicker) {
                                VStack {
                                    DatePicker("Select End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                                        .datePickerStyle(.graphical)
                                        .tint(.green)
                                        .padding()
                                    
                                    Button("Done") {
                                        showEndPicker = false
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                                }
                                .padding()
                                .presentationDetents([.medium, .large])
                            }
                        }
                        
                        Spacer()
                        Spacer()
                        
                        VStack(alignment: .center) {
                            // Selected image ya placeholder
                            if let selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Rectangle())
                            } else {
                                Image(systemName: "doc.text.fill")
                                    .resizable()
                                    .frame(width: 100, height: 110)
                                    .foregroundColor(.gray)
                            }
                            
                            // Upload Certificate Button
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                Text("Upload Certificate")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            .padding(.horizontal)
                            .padding(.top)
                            
                            Text("JPG or PNG format, Maximum 5 MB")
                                .font(.caption)
                                .foregroundColor(.black)
                                .onChange(of: selectedItem) { _, newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                                           let uiImage = UIImage(data: data) {
                                            selectedImage = uiImage
                                            // Certificate ko base64 mein convert kar sakte hain ya file upload kar sakte hain
                                            certificateUrl = "uploaded_certificate_url" // Placeholder
                                        }
                                    }
                                }
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                
                // Navigation buttons outside ScrollView
                HStack {
                    NavigationLink(destination: CreateProfilePicture()) {
                        Text("Previous")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                            .padding(.vertical)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        print("Previous button pressed")
                    })
                    
                    Button(action: {
                        // Pehle data validate karo
                        if validateInputs() {
                            sendEducationData()
                        }
                    }) {
                        if isLoading {
                            HStack {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                                Text("Saving...")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        } else {
                            Text("Save & Next")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(13)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                    .cornerRadius(10)
                    .padding(.vertical)
                    .disabled(isLoading)
                }
            }
            .padding()
            .frame(maxHeight: .infinity)
            .navigationBarHidden(true)
            .alert("Education Profile", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // MARK: - Validation Function
    private func validateInputs() -> Bool {
        if university.isEmpty {
            alertMessage = "Please enter university name"
            showAlert = true
            return false
        }
        
        if degree.isEmpty {
            alertMessage = "Please enter your degree"
            showAlert = true
            return false
        }
        
        if endDate < startDate {
            alertMessage = "End date cannot be earlier than start date"
            showAlert = true
            return false
        }
        
        return true
    }
    
    // MARK: - API Call Function
    private func sendEducationData() {
        isLoading = true
        
        // Date formatter - backend ko ISO string format mein bhejenge
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        // Request body banao
        var requestBody: [String: Any] = [
            "University": university,
            "Degree": degree,
            "Specialization": specialization.isEmpty ? "" : specialization,
            "StartDate": dateFormatter.string(from: startDate),
            "EndDate": dateFormatter.string(from: endDate),
            //"CertificateUrl": certificateUrl.isEmpty ? nil : certificateUrl
        ]
        
        if !certificateUrl.isEmpty {
            requestBody["CertificateUrl"] = certificateUrl  // ✅ Now works!
        }
        
        // URL aur request setup
        guard let url = URL(string: "http://localhost:8020/app/CreateEducation") else {
            alertMessage = "Invalid URL"
            showAlert = true
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // JWT Token - UserDefaults se lao (same key jo AboutUS me use ho rahi hai)
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            print("📱 Using token: \(token)")
        } else {
            alertMessage = "No authentication token found. Please login again."
            showAlert = true
            isLoading = false
            return
        }
        
        // JSON body set karo
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonData
        } catch {
            alertMessage = "Error creating request: \(error.localizedDescription)"
            showAlert = true
            isLoading = false
            return
        }
        
        // API call karo
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    alertMessage = "Network error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                
                guard let data = data else {
                    alertMessage = "No data received"
                    showAlert = true
                    return
                }
                
                // Response parse karo
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        if let status = jsonResponse["status"] as? Int, status == 1 {
                            // Success
                            alertMessage = jsonResponse["message"] as? String ?? "Education data saved successfully!"
                            showAlert = true
                            
                            // Success ke baad next screen pe navigate karo
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                // Navigation to next screen
                                // Ye tumhare navigation structure ke hisab se adjust karo
                            }
                        } else {
                            // Error
                            alertMessage = jsonResponse["message"] as? String ?? "Failed to save education data"
                            showAlert = true
                        }
                    }
                } catch {
                    alertMessage = "Error parsing response: \(error.localizedDescription)"
                    showAlert = true
                }
            }
        }.resume()
    }
}

#Preview {
    CreateProfileEducation()
}
