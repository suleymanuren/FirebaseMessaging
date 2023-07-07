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
            
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach ( messageService.messages) { message in
                        ChatBubble(messages: message,userID: userId)
                    }
                }
                .padding(.top,10)
                .background(.white)
                .cornerRadius(12)
                .onChange(of: messageService.lastMessageId) { id in
                    withAnimation {
                        proxy.scrollTo(id, anchor: .bottom)
                    }
                }
            }
            Divider()
            HStack{
                TextField("Mesaj Gönder", text: $message)

                Button {
                    messageService.sendMessage(text: message,userID: userId )
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
