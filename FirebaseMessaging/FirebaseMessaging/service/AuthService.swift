//
//  AuthService.swift
//  FirebaseMessaging
//
//  Created by Bulut Sistem on 7.07.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AuthService: ObservableObject {
    let db = Firestore.firestore()
    @Published var userId = ""
    @Published var isLoginSucces = false

    func getRegister (mail : String , name: String, password : String) {
        do {
            let newUser = RegisterModel(id: "\(UUID())",mail: mail, name: name, password: password)
            Auth.auth().createUser(withEmail: mail, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                
                if let user = authResult?.user {
                    let userID = user.uid
                    print("User ID: \(userID)")
                    // Use the userID as needed
                    UserDefaults.standard.set(user.uid, forKey: "userID")

                } else if let error = error {
                    print("Register error: \(error.localizedDescription)")
                }
                
            }
            try db.collection("users").document().setData(from: newUser)
        }
        catch {
            print("register fail \(error.localizedDescription)")
        }
    }
    
    
    func login(mail: String, password: String) {
        Auth.auth().signIn(withEmail: mail, password: password) { (result, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
            } else {
                if let user = result?.user {
                    let userID = user.uid
                    print("User ID: \(userID)")
                    self.userId = userID
                    // Use the userID as needed
                    UserDefaults.standard.set(user.uid, forKey: "userID")

                }
                print("Login success")
                self.isLoginSucces = true

            }
        }
    }

}
