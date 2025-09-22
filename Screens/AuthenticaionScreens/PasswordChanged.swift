
//

//import SwiftUI
//
//struct PasswordChanged: View {
//   
//    
//    
//    var body: some View {
//        NavigationStack {
//            GeometryReader { geo in
//                
//                VStack {
//                    ScrollView {
//                        Spacer()
//                            .frame(height: geo.size.height * 0.49)
//                        
//                        VStack(alignment: .center, spacing: 10) {
//                            Text("Password Changed")
//                                .font(.system(size: 20))
//                            // .font(.largeTitle)
//                                .fontWeight(.bold)
//                            
//                            
//                            Text("Your password has been changed successfully!")
//                                .font(.system(size: 12))
//                                .fontWeight(.light)
//                                
//                            Spacer()
//                                .frame(height: geo.size.height * 0.26)
//                          
//                            NavigationLink(destination: Login()) {
//                                Text("Go Back to Login")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                                    .padding(13)
//                                    .frame(maxWidth: .infinity)
//                                    .background(Color(red: 12/255, green: 144/255, blue: 121/255))
//                                    .cornerRadius(10)
//                                    .padding(.vertical)
//                            }
//                            .simultaneousGesture(TapGesture().onEnded {
//                                print("Reset Password button pressed")
//                            })
//                        }
//                      
//                    }
//                    .padding()
//                }}}
//        }
//    }
//
//#Preview {
//    PasswordChanged()
//}





import SwiftUI

struct PasswordChanged: View {
    @State private var navigateToNext = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Spacer()
                
                
                // Green checkmark circle
                ZStack {
                    Circle()
                        .stroke(Color.green, lineWidth: 3)
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.green)
                }
                .padding(.bottom, 40)
                
                // Success text
                Text("Password Changed")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                // Description text
                Text("Your password has been changed successfully!")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                
                Spacer()
                Spacer()
                
                // Continue button
                Button(action: {
                    navigateToNext = true
                }) {
                    Text("Go Back Log In Page")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                // Navigation to next screen
                NavigationLink(
                    destination: Login(), // Random screen
                    isActive: $navigateToNext
                ) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
            .background(Color.white)
        }
    }
}


#Preview {
    PasswordChanged()
}
