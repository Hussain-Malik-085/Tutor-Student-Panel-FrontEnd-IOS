import SwiftUI
import PhotosUI

struct CreateProfilePicture: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentPhase: String = "Photo  >"
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil

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
                    .padding(.bottom,2)

                VStack(alignment: .center) {
                    // ✅ Selected image ya placeholder
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Rectangle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    }

                    // ✅ Photo picker
                    PhotosPicker("Pick an Image", selection: $selectedItem, matching: .images)
                        .onChange(of: selectedItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    selectedImage = uiImage
                                }
                            }
                        }

                    // ✅ Upload button
                    if let img = selectedImage {
                        Button("Upload Image") {
                            uploadProfileImage(image: img)
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.vertical)
                    }

                    Spacer()

                    // Navigation buttons
                    HStack {
                        NavigationLink(destination: CreateProfileAboutUS()) {
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

                        NavigationLink(destination: CreateProfileEducation()) {
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
        }
    }

    // --- 📤 Upload Function ---
    func uploadProfileImage(image: UIImage) {
        guard let url = URL(string: "http://localhost:8020/app/ProfilePicture") else { return }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }

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
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Error uploading image: \(error.localizedDescription)")
                return
            }
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) {
                print("✅ Response: \(json)")
            }
        }.resume()
    }
}
#Preview { CreateProfilePicture() }
// Splash.swift
// Tutor Panel // // Created by MetaDots on 22/08/2025. // // // CreateProfile-Picture.swift // Tutor Panel // // Created by MetaDots on 25/08/2025.
