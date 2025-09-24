import SwiftUI
import PhotosUI

struct CreateProfileEducation: View {
    @Environment(\.dismiss) var dismiss
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
    
    // API states
    @State private var isLoading = false
    @State private var isLoadingData = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var certificateUrl = ""
    @State private var hasExistingData = false
    @State private var navigateNext = false
    
    let items = [
        "About Us >", "Photo >", "Certification >", "Education >",
        "Skills >", "Description >", "Availability >", "ID Card Verification "
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Back button and title
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
                .padding(.horizontal)
                
                // Loading indicator for data fetch
                if isLoadingData {
                    ProgressView("Loading existing data...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                
                // Horizontal phase indicator
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(items, id: \.self) { item in
                                Text(item)
                                    .font(.caption)
                                    .foregroundColor(item == currentPhase ? .red : .black)
                                    .fontWeight(item == currentPhase ? .bold : .regular)
                                    .id(item)
                            }
                        }
                    }
                    .onChange(of: currentPhase) { _, newValue in
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .leading)
                        }
                    }
                    .onAppear {
                        proxy.scrollTo(currentPhase, anchor: .leading)
                    }
                }
                .padding(.horizontal)
                
                // Education title and description
                HStack {
                    Text("Education")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
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
                .padding(.horizontal)
                
                Text("Please provide your educational background details")
                    .font(.caption)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
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
                                        .onChange(of: startDate) { _, newStartDate in
                                            if endDate < newStartDate {
                                                endDate = newStartDate
                                            }
                                        }
                                    
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
                            // Selected image or placeholder
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
                                            print("Certificate image selected")
                                        }
                                    }
                                }
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                }
                
                // Navigation buttons
                HStack {
                    // Previous button - Fixed navigation
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

                    // Save & Next button
                    Button(action: {
                        if validateInputs() {
                            Task {
                                await handleSaveAndNext()
                            }
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
                .padding(.horizontal)
                
                // Hidden NavigationLink for Next screen - Fixed navigation
                NavigationLink(
                    destination: CreateProfileDescription(),
                    isActive: $navigateNext
                ) {
                    EmptyView()
                }
            }
            .padding(.vertical)
            .frame(maxHeight: .infinity)
            .navigationBarHidden(true)
            .alert("Education Profile", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    // Navigation after successful save
                    if alertMessage.contains("successfully") || alertMessage.contains("Successfully") {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            navigateNext = true
                        }
                    }
                }
            } message: {
                Text(alertMessage)
            }
            .onAppear {
                Task {
                    await fetchExistingEducationData()
                }
            }
        }
    }
    
    // MARK: - Handle Save and Next
    @MainActor
    func handleSaveAndNext() async {
        isLoading = true
        let success = await sendEducationDataWithCertificate()
        isLoading = false
        
        if success {
            // Navigation will happen in alert OK button
        }
    }
    
    // MARK: - Fetch Existing Data Function - COMPLETE FIX
    private func fetchExistingEducationData() async {
        await MainActor.run {
            isLoadingData = true
        }
        
        guard let url = URL(string: "http://localhost:8020/app/tutor/geteducation") else {
            print("Invalid URL for fetching education data")
            await MainActor.run {
                isLoadingData = false
            }
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            print("No auth token found")
            await MainActor.run {
                isLoadingData = false
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("Fetching existing education data...")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            await MainActor.run {
                isLoadingData = false
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No HTTP response")
                return
            }
            
            print("Fetch status code: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode == 200 {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response: \(jsonResponse)")
                        
                        if let status = jsonResponse["status"] as? Int, status == 1,
                           let educationData = jsonResponse["data"] as? [String: Any] {
                            
                            await MainActor.run {
                                university = educationData["University"] as? String ?? ""
                                degree = educationData["Degree"] as? String ?? ""
                                specialization = educationData["Specialization"] as? String ?? ""
                                certificateUrl = educationData["CertificateUrl"] as? String ?? ""
                                
                                // FIXED: Better date parsing with UTC handling
                                let isoFormatter = ISO8601DateFormatter()
                                isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                                
                                let backupFormatter = DateFormatter()
                                backupFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                                backupFormatter.timeZone = TimeZone(abbreviation: "UTC")
                                
                                let simpleFormatter = DateFormatter()
                                simpleFormatter.dateFormat = "yyyy-MM-dd"
                                simpleFormatter.timeZone = TimeZone.current
                                
                                if let startDateString = educationData["StartDate"] as? String {
                                    print("Parsing StartDate: \(startDateString)")
                                    
                                    if let parsedDate = isoFormatter.date(from: startDateString) {
                                        startDate = parsedDate
                                        print("Parsed StartDate with ISO8601: \(startDate)")
                                    } else if let parsedDate = backupFormatter.date(from: startDateString) {
                                        startDate = parsedDate
                                        print("Parsed StartDate with backup formatter: \(startDate)")
                                    } else if let parsedDate = simpleFormatter.date(from: startDateString) {
                                        startDate = parsedDate
                                        print("Parsed StartDate with simple formatter: \(startDate)")
                                    } else {
                                        print("Failed to parse StartDate: \(startDateString)")
                                    }
                                }
                                
                                if let endDateString = educationData["EndDate"] as? String {
                                    print("Parsing EndDate: \(endDateString)")
                                    
                                    if let parsedDate = isoFormatter.date(from: endDateString) {
                                        endDate = parsedDate
                                        print("Parsed EndDate with ISO8601: \(endDate)")
                                    } else if let parsedDate = backupFormatter.date(from: endDateString) {
                                        endDate = parsedDate
                                        print("Parsed EndDate with backup formatter: \(endDate)")
                                    } else if let parsedDate = simpleFormatter.date(from: endDateString) {
                                        endDate = parsedDate
                                        print("Parsed EndDate with simple formatter: \(endDate)")
                                    } else {
                                        print("Failed to parse EndDate: \(endDateString)")
                                    }
                                }
                                
                                hasExistingData = true
                                print("Education data loaded successfully!")
                                print("Final dates - Start: \(startDate), End: \(endDate)")
                            }
                            
                            if !certificateUrl.isEmpty {
                                await loadCertificateImage()
                            }
                            
                        } else if let status = jsonResponse["status"] as? Int, status == 0 {
                            print("No existing education data found")
                            await MainActor.run {
                                hasExistingData = false
                            }
                        }
                    }
                } catch {
                    print("Error parsing response: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Network error: \(error.localizedDescription)")
            await MainActor.run {
                isLoadingData = false
            }
        }
    }
    
    // MARK: - Load Certificate Image from URL
    private func loadCertificateImage() async {
        guard !certificateUrl.isEmpty, let url = URL(string: certificateUrl) else {
            print("Invalid certificate URL: \(certificateUrl)")
            return
        }
        
        print("Loading certificate image from URL: \(url.absoluteString)")
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard data.count > 0, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            
            await MainActor.run {
                self.selectedImage = image
            }
            
            print("Certificate image loaded successfully!")
            
        } catch {
            print("Error loading certificate image: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Validation Function - IMPROVED
    private func validateInputs() -> Bool {
        if university.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Please enter university name"
            showAlert = true
            return false
        }
        
        if degree.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Please enter your degree"
            showAlert = true
            return false
        }
        
        // FIXED: More accurate date comparison
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
        let endComponents = calendar.dateComponents([.year, .month, .day], from: endDate)
        
        guard let startDateOnly = calendar.date(from: startComponents),
              let endDateOnly = calendar.date(from: endComponents) else {
            alertMessage = "Invalid date selection"
            showAlert = true
            return false
        }
        
        if endDateOnly < startDateOnly {
            alertMessage = "End date cannot be earlier than start date"
            showAlert = true
            return false
        }
        
        print("✅ Date validation passed - Start: \(startDateOnly), End: \(endDateOnly)")
        return true
    }
    
    // MARK: - Send Education Data Function - COMPLETE DATE FIX
    private func sendEducationDataWithCertificate() async -> Bool {
        guard let url = URL(string: "http://localhost:8020/app/tutor/createeducation") else {
            await MainActor.run {
                alertMessage = "Invalid URL"
                showAlert = true
            }
            return false
        }
        
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            await MainActor.run {
                alertMessage = "No authentication token found. Please login again."
                showAlert = true
            }
            return false
        }
        
        let boundary = UUID().uuidString
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // FIXED: Use UTC date formatter to avoid timezone issues
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        var body = Data()
        
        // FIXED: Convert dates to UTC and format properly
        let formattedStartDate = dateFormatter.string(from: startDate)
        let formattedEndDate = dateFormatter.string(from: endDate)
        
        print("Formatted StartDate (UTC): \(formattedStartDate)")
        print("Formatted EndDate (UTC): \(formattedEndDate)")
        
        // Add form fields
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"University\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(university.trimmingCharacters(in: .whitespacesAndNewlines))\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"Degree\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(degree.trimmingCharacters(in: .whitespacesAndNewlines))\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"Specialization\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(specialization.trimmingCharacters(in: .whitespacesAndNewlines))\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"StartDate\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(formattedStartDate)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"EndDate\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(formattedEndDate)\r\n".data(using: .utf8)!)
        
        // Only add image if user has made a NEW selection
        if let selectedItem = selectedItem,
           let selectedImage = selectedImage,
           let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"certificate\"; filename=\"certificate.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            print("NEW Certificate image added to request")
            
            // Clear the selectedItem after using it
            await MainActor.run {
                self.selectedItem = nil
            }
        } else {
            print("No new image selected - keeping existing certificate")
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        print("Sending education data to backend...")
        print("Data being sent - University: \(university), Degree: \(degree)")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Debug: Print full response
            if let responseString = String(data: data, encoding: .utf8) {
                print("Full Backend Response: \(responseString)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                await MainActor.run {
                    alertMessage = "Invalid response from server"
                    showAlert = true
                }
                return false
            }
            
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode == 200 {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Parsed JSON Response: \(jsonResponse)")
                        
                        if let status = jsonResponse["status"] as? Int, status == 1 {
                            await MainActor.run {
                                alertMessage = jsonResponse["message"] as? String ?? "Education data saved successfully!"
                                hasExistingData = true
                                
                                // Update certificate URL if provided in response
                                if let responseData = jsonResponse["data"] as? [String: Any],
                                   let certUrl = responseData["CertificateUrl"] as? String {
                                    certificateUrl = certUrl
                                    print("Updated certificate URL: \(certUrl)")
                                }
                                
                                showAlert = true
                            }
                            
                            print("Education data saved successfully!")
                            return true
                        } else {
                            let errorMessage = jsonResponse["message"] as? String ?? "Unknown error occurred"
                            await MainActor.run {
                                alertMessage = "Server Error: \(errorMessage)"
                                showAlert = true
                            }
                            print("Server returned error: \(errorMessage)")
                            return false
                        }
                    }
                } catch {
                    await MainActor.run {
                        alertMessage = "Error parsing server response: \(error.localizedDescription)"
                        showAlert = true
                    }
                    print("JSON parsing error: \(error)")
                    return false
                }
            } else if httpResponse.statusCode == 400 {
                // Handle 400 error specifically
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let errorMessage = jsonResponse["message"] as? String {
                    await MainActor.run {
                        alertMessage = "Validation Error: \(errorMessage)"
                        showAlert = true
                    }
                    print("Backend validation error: \(errorMessage)")
                } else {
                    await MainActor.run {
                        alertMessage = "Server validation error (400)"
                        showAlert = true
                    }
                }
                return false
            } else {
                let statusCode = httpResponse.statusCode
                await MainActor.run {
                    alertMessage = "Server error with status code: \(statusCode)"
                    showAlert = true
                }
                print("HTTP Error: Status \(statusCode)")
                return false
            }
        } catch {
            await MainActor.run {
                alertMessage = "Network error: \(error.localizedDescription)"
                showAlert = true
            }
            print("Network error: \(error)")
            return false
        }
        
        return false
    }
}

#Preview {
    CreateProfileEducation()
}
