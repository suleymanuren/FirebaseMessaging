//
//  LoginScreenView.swift
//  FirebaseMessaging
//
//  Created by Bulut Sistem on 7.07.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct LoginScreenView: View {
    @StateObject private var authService = AuthService()
    
    @State var mail = "test1@gmail.com"
    @State var password = "123456"
    
    var body: some View {
        if authService.isLoginSucces {
            MessageScreenView(userId: authService.userId)
        } else {
            NavigationView {
                VStack {
                    VStack (spacing: 12){
                        TextField("Email", text: $mail)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        
                        Button(action: {
                            authService.login(mail: mail, password: password)
                        }) {
                            Text("Sign in")
                                .padding()
                                .foregroundColor(.black)
                                .background(Color(.systemGreen).opacity(0.5))
                                .cornerRadius(12)
                        }
                        
                    }
                    .padding()
                    
                    NavigationLink {
                        RegisterScreenView()
                    } label: {
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                            
                            Text("Register")
                            
                            Rectangle()
                                .frame(height: 1)
                        }
                        .padding()
                    }
                    
                    
                }
            }
        }
    }
}
struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
