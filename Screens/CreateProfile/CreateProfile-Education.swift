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
    @State private var isLoadingData = false // New: data fetch ke liye
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var certificateUrl = ""
    @State private var hasExistingData = false // New: check existing data
    
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
                
                // Loading indicator for data fetch
                if isLoadingData {
                    ProgressView("Loading existing data...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
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
                HStack {
                    Text("Education")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Show indicator if data exists
                    if hasExistingData {
                        Text("✅ Data Found")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                
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
                                Text(hasExistingData && !certificateUrl.isEmpty ? "Change Certificate" : "Upload Certificate")
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
                                            print("📁 Certificate image selected")
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
                        if validateInputs() {
                            sendEducationDataWithCertificate()
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
                            Text(hasExistingData ? "Update & Next" : "Save & Next")
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
            .onAppear {
                // View load hone pe existing data fetch karo
                fetchExistingEducationData()
            }
        }
    }
    
    // MARK: - NEW: Fetch Existing Data Function
    private func fetchExistingEducationData() {
        isLoadingData = true
        
        guard let url = URL(string: "http://localhost:8020/app/GetEducation") else {
            print("❌ Invalid URL for fetching education data")
            isLoadingData = false
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            print("❌ No auth token found")
            isLoadingData = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("📤 Fetching existing education data...")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoadingData = false
                
                if let error = error {
                    print("❌ Network error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("❌ No data received")
                    return
                }
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("📱 Response: \(jsonResponse)")
                        
                        if let status = jsonResponse["status"] as? Int, status == 1,
                           let educationData = jsonResponse["data"] as? [String: Any] {
                            
                            // Fields auto-fill karo - Backend format ke according
                            university = educationData["University"] as? String ?? ""
                            degree = educationData["Degree"] as? String ?? ""
                            specialization = educationData["Specialization"] as? String ?? ""
                            certificateUrl = educationData["CertificateUrl"] as? String ?? ""
                            
                            // Dates parse karo
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            
                            if let startDateString = educationData["StartDate"] as? String,
                               let parsedStartDate = dateFormatter.date(from: startDateString) {
                                startDate = parsedStartDate
                            }
                            
                            if let endDateString = educationData["EndDate"] as? String,
                               let parsedEndDate = dateFormatter.date(from: endDateString) {
                                endDate = parsedEndDate
                            }
                            
                            // Certificate image load karo (agar URL hai)
                            if !certificateUrl.isEmpty {
                                loadCertificateImage()
                            }
                            
                            hasExistingData = true
                            print("✅ Education data loaded successfully!")
                            
                        } else if let status = jsonResponse["status"] as? Int, status == 0 {
                            // No existing data found - normal case
                            print("ℹ️ No existing education data found")
                            hasExistingData = false
                        }
                    }
                } catch {
                    print("❌ Error parsing response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    // MARK: - Load Certificate Image from URL
    private func loadCertificateImage() {
        guard !certificateUrl.isEmpty, let url = URL(string: certificateUrl) else {
            print("❌ Invalid certificate URL: \(certificateUrl)")
            return
        }

        // Fix double slashes and localhost
        var mutableUrl = url.absoluteString
        mutableUrl = mutableUrl.replacingOccurrences(of: "//", with: "/")
        mutableUrl = mutableUrl.replacingOccurrences(of: "localhost", with: "127.0.0.1")
        guard let fixedUrl = URL(string: mutableUrl) else {
            print("❌ Failed to create fixed URL: \(mutableUrl)")
            return
        }

        print("📥 Loading certificate image from URL: \(fixedUrl.absoluteString)")

        URLSession.shared.dataTask(with: fixedUrl) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ Error loading certificate image: \(error.localizedDescription)")
                    print("❌ Full error: \(error)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("📊 HTTP Status Code: \(httpResponse.statusCode)")
                    print("📊 Headers: \(httpResponse.allHeaderFields)")
                }

                guard let data = data, data.count > 0 else {
                    print("❌ No data received (nil or empty data)")
                    return
                }

                print("📊 Data size: \(data.count) bytes")

                guard let image = UIImage(data: data) else {
                    print("❌ Invalid image data - Data might be corrupted or not an image")
                    if let base64 = String(data: data.prefix(100), encoding: .utf8) {
                        print("🔍 First 100 bytes as text: \(base64)")
                    }
                    return
                }

                self.selectedImage = image
                print("✅ Certificate image loaded successfully! Size: \(data.count) bytes")
            }
        }.resume()
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
    
    // MARK: - Multipart Upload Function (unchanged)
    private func sendEducationDataWithCertificate() {
        isLoading = true
        
        guard let url = URL(string: "http://localhost:8020/app/CreateEducation") else {
            alertMessage = "Invalid URL"
            showAlert = true
            isLoading = false
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            alertMessage = "No authentication token found. Please login again."
            showAlert = true
            isLoading = false
            return
        }
        
        let boundary = UUID().uuidString
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        var body = Data()
        
        // Add text fields
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"University\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(university)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"Degree\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(degree)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"Specialization\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(specialization)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"StartDate\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(dateFormatter.string(from: startDate))\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"EndDate\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(dateFormatter.string(from: endDate))\r\n".data(using: .utf8)!)
        
        // Add certificate file if selected
        if let selectedImage = selectedImage,
           let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"certificate\"; filename=\"certificate.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            print("📤 Certificate image added to request")
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        print("📤 Sending multipart request...")
        
        // API call
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
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("📱 Response received: \(jsonResponse)")
                        
                        if let status = jsonResponse["status"] as? Int, status == 1 {
                            // Success
                            alertMessage = jsonResponse["message"] as? String ?? "Education data saved successfully!"
                            showAlert = true
                            hasExistingData = true
                            
                            // Success ke baad next screen pe navigate karo
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                print("✅ Education data saved successfully!")
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
