//
//  MessageScreenView.swift
//  FirebaseMessaging
//
//  Created by Bulut Sistem on 7.07.2023.
//

import SwiftUI

struct MessageScreenView: View {
    @StateObject private var messageService = MessageService()
    @State private var message = ""
    let userId : String
    
    var body: some View {
        VStack {
       
            ChatBubble(userID: userId)
               
            Divider()
            HStack{
                TextField(userId, text: $message)

                Button {
                    messageService.sendMessage(text: message,senderId: userId , receiverId: userId == "Dd2YMSBwWvfBHCq3p7e8pdd3fSF3" ? "XQL3QL52BbWVEwMKKgMYwHVbDEH2" : "")
                    message = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                }

            }
            .padding()
            .background(.secondary.opacity(0.3))
            .cornerRadius(12)
            .padding()

        }.onAppear {
            messageService.getMessages()
        }
    }
}

struct MessageScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MessageScreenView(userId: "123")
    }
}
