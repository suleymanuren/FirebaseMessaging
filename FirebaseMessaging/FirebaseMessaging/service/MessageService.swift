//
//  MessageService.swift
//  FirebaseMessaging
//
//  Created by Bulut Sistem on 7.07.2023.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessageService : ObservableObject {
    
    @Published var messages = [Message] ()
    let db = Firestore.firestore()
    @Published var lastMessageId = ""
  
    init () {
        getMessages()
    }
    // Read message from Firestore in real-time with the addSnapShotListener
    func getMessages() {
        db.collection("messages").addSnapshotListener { querySnapshot, error in
            
            // If we don't have documents, exit the function
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Mapping through the documents
            self.messages = documents.compactMap { document -> Message? in
                do {

                    // Converting each document into the Message model
                    // Note that data(as:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
                    return try document.data(as: Message.self)
                } catch {
                    // If we run into an error, print the error in the console
                    print("Error decoding document into Message: \(error)")

                    // Return nil if we run into an error - but the compactMap will not include it in the final array
                    return nil
                }
            }
            
            // Sorting the messages by sent date
            self.messages.sort { $0.timestamp < $1.timestamp }
            
            // Getting the ID of the last message so we automatically scroll to it in ContentView
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
  
    // Add a message in Firestore
    func sendMessage(text: String,userID : String) {
        do {
            // Create a new Message instance, with a unique ID, the text we passed, a received value set to false (since the user will always be the sender), and a timestamp
            let newMessage = Message(id: "\(UUID())", message: text,receiverID: "Dd2YMSBwWvfBHCq3p7e8pdd3fSF3",senderID: "XQL3QL52BbWVEwMKKgMYwHVbDEH2", timestamp: Date())
            
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            try db.collection("messages").document().setData(from: newMessage)
            
        print("gelen")
            
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)")
        }
    }
}
