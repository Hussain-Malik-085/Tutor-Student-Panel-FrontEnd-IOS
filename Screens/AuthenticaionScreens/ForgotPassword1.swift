import SwiftUI

struct ForgotPassword1: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geo in   
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Forgot Password")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        
                        Text("We’ve sent reset password link to your email")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .padding(.bottom, 4)
                        
                        Text("alisonh952@gmail.com")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .padding(.bottom, 4)
                        
                      
                        Spacer()
                            .frame(height: geo.size.height * 0.61)
                        
                        // --- Buttons ---
                        NavigationLink(
                            destination: SetNewPassword(),
                            label: {
                                Text("Continue")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(13)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 12/255, green: 144/255, blue: 121/255))
                                    .cornerRadius(10)
                                    .padding(.vertical)
                            }
                        )
                        .simultaneousGesture(TapGesture().onEnded {
                            print("Continue button pressed")
                        })
                        
                        NavigationLink(
                            destination: Login(),
                            label: {
                                Text("Back To Log In")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                    .cornerRadius(10)
                            }
                        )
                        .simultaneousGesture(TapGesture().onEnded {
                            print("Back To Log In button pressed")
                        })
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ForgotPassword1()
}
