import SwiftUI
import PhotosUI

struct CreateProfileCertificate: View {
    @State private var selectedImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        VStack(alignment: .center) {
            // Selected image ya placeholder
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Rectangle())
            } else {
                Image(systemName: "doc.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
            
            // Upload Certificate Button
            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ) {
               
                    Text("Upload Certificate")
                        .font(.headline)
                        .foregroundColor(.gray)
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
           
            
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
                    }
                }
            }
        }
    }
}
    #Preview {
        CreateProfileCertificate()
    }
