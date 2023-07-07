//
//  RegisterScreenView.swift
//  FirebaseMessaging
//
//  Created by Bulut Sistem on 7.07.2023.
//

import SwiftUI

struct RegisterScreenView: View {
    @StateObject private var authService = AuthService()
    @State var mail = ""
    @State var name = ""
    @State var password = ""

    var body: some View {
        VStack (spacing: 12){
            TextField("Email", text: $mail)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            TextField("Name", text: $name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            
            Button(action: {
                authService.getRegister(mail: mail, name: name, password: password)
            }) {
                Text("Sign up")
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(.systemGreen).opacity(0.5))
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}

struct RegisterScreenView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreenView()
    }
}
