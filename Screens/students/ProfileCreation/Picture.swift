//
//  Picture.swift
//  Tutor Panel
//
//  Created by MetaDots on 19/09/2025.
//

import SwiftUI
import PhotosUI

struct ProfilePicture: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentPhase: String = "Photo  >"
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    
    // API states
    @State private var isLoadingData = false
    @State private var hasExistingData = false
    @State private var profilePictureUrl = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isUploading = false // New: Upload loading state

    let items = [
        "Basic Info  >",
        "Photo  >",
        "Academic Info  >",
        
    ]

    var body: some View {
        NavigationStack {
            VStack {
                // 🔙 Back button
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

                // Loading indicator
                if isLoadingData {
                    ProgressView("Loading existing profile picture...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }

                // 🔄 Steps horizontal scroll
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

                Text("Profile Photo")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .font(.caption)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 2)

                VStack(alignment: .center) {
                    // ✅ Image display section
                    if let selectedImage {
                        // Show locally selected image
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 4)
                    } else if hasExistingData && !profilePictureUrl.isEmpty {
                        // Show existing image from URL
                        AsyncImage(url: URL(string: profilePictureUrl)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 200, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 4)
                            case .failure(_):
                                // Show error placeholder
                                Image(systemName: "photo.badge.exclamationmark")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.red)
                            case .empty:
                                // Show loading placeholder
                                ProgressView()
                                    .frame(width: 200, height: 200)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        // Show default placeholder
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    }

                    // ✅ Photo picker
                    PhotosPicker(
                        hasExistingData && !profilePictureUrl.isEmpty ? "Change Image" : "Pick an Image",
                        selection: $selectedItem,
                        matching: .images
                    )
                    .onChange(of: selectedItem) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                selectedImage = uiImage
                                print("📁 Profile image selected locally")
                            }
                        }
                    }

                    // ✅ Upload button with loading state
                    if let img = selectedImage {
                        Button(action: {
                            uploadProfileImage(image: img)
                        }) {
                            HStack {
                                if isUploading {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                        .foregroundColor(.white)
                                }
                                Text(isUploading ? "Uploading..." : "Upload Image")
                            }
                        }
                        .disabled(isUploading)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isUploading ? Color.gray : Color.green)
                        .cornerRadius(10)
                        .padding(.vertical)
                    }

                    Spacer()

                    // Navigation buttons
                    HStack {
                        NavigationLink(destination: BasicInfoProfile()) {
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

                        NavigationLink(destination: AcademicInfo()) {
                            Text("Next")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(13)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                                .cornerRadius(10)
                                .padding(.vertical)
                        }
                    }
                }
            }
            .padding()
            .navigationBarHidden(true)
            .alert("Profile Picture", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            .onAppear {
                fetchExistingProfilePicture()
            }
        }
    }

    // MARK: - Fetch Existing Profile Picture
    private func fetchExistingProfilePicture() {
        isLoadingData = true
        
        guard let url = URL(string: "http://127.0.0.1:8020/app/student/GetProfilePic") else {
            print("❌ Invalid URL for fetching profile picture")
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
        
        print("📤 Fetching existing profile picture...")
        
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
                        print("📱 Profile Response: \(jsonResponse)")
                        
                        if let status = jsonResponse["status"] as? Int, status == 1,
                           let profileData = jsonResponse["data"] as? [String: Any] {
                            
                            // Get picture URL from response
                            profilePictureUrl = profileData["pictureUrl"] as? String ?? ""
                            
                            // Fix localhost to 127.0.0.1 for simulator
                            if !profilePictureUrl.isEmpty {
                                profilePictureUrl = profilePictureUrl.replacingOccurrences(of: "localhost", with: "127.0.0.1")
                                print("🔄 Profile picture URL: \(profilePictureUrl)")
                            }
                            
                            hasExistingData = !profilePictureUrl.isEmpty
                            print("✅ Profile picture data loaded successfully!")
                            
                        } else if let status = jsonResponse["status"] as? Int, status == 0 {
                            print("ℹ️ No existing profile picture found")
                            hasExistingData = false
                        }
                    }
                } catch {
                    print("❌ Error parsing response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    // MARK: - Upload Profile Image
    func uploadProfileImage(image: UIImage) {
        guard let url = URL(string: "http://127.0.0.1:8020/app/ProfilePicture") else {
            alertMessage = "Invalid URL"
            showAlert = true
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            alertMessage = "No authentication token found. Please login again."
            showAlert = true
            return
        }

        isUploading = true // Start upload loading
        
        let boundary = UUID().uuidString
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        var body = Data()

        if let imageData = image.jpegData(compressionQuality: 0.8) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"profilePicture\"; filename=\"profile.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            print("📤 Profile image added to request")
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body

        print("📤 Uploading profile image...")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isUploading = false // Stop upload loading
                
                if let error = error {
                    alertMessage = "Upload failed: \(error.localizedDescription)"
                    showAlert = true
                    print("❌ Error uploading image: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    alertMessage = "No response received"
                    showAlert = true
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("📊 Status Code: \(httpResponse.statusCode)")
                }
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("✅ Response: \(jsonResponse)")
                        
                        if let status = jsonResponse["status"] as? Int, status == 1 {
                            alertMessage = jsonResponse["message"] as? String ?? "Profile picture uploaded successfully!"
                            showAlert = true
                            hasExistingData = true
                            
                            // Update profile picture URL from response
                            if let pictureUrl = jsonResponse["pictureUrl"] as? String {
                                profilePictureUrl = pictureUrl.replacingOccurrences(of: "localhost", with: "127.0.0.1")
                                print("🔄 Updated profile picture URL: \(profilePictureUrl)")
                            }
                            
                            // Clear local image, URL se load ho jayega
                            selectedImage = nil
                            
                            print("✅ Profile picture uploaded successfully!")
                        } else {
                            alertMessage = jsonResponse["message"] as? String ?? "Upload failed"
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
    ProfilePicture()
}
