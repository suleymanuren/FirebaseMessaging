//
//  ChatBubble.swift
//  FirebaseMessaging
//
//  Created by Bulut Sistem on 7.07.2023.
//

import SwiftUI

struct ChatBubble: View {
    let messages : Message
    @State private var showTime = false
    let userID : String

    var body: some View {
        VStack(alignment: messages.receiverID == userID ? .leading : .trailing) {
            HStack {
                Image(messages.receiverID == userID ? "" : "sender")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                Text(messages.message)
                    .padding()
                    .background(messages.receiverID != userID ? Color(.systemGray).opacity(0.5) : Color(.systemGreen).opacity(0.8))
                    .clipShape(ChatBubbleRadius(isFromSender: messages.receiverID == userID ? true : false ))
                
                Image(messages.receiverID != userID ? "receiver" : "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
            }
            .frame(maxWidth: 300, alignment: messages.receiverID == userID ? .trailing : .leading)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                withAnimation {
                    Text("\(messages.timestamp.formatted(.dateTime.hour().minute()))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(messages.receiverID == userID ? .leading : .trailing)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: messages.receiverID == userID ? .leading : .trailing)
        .padding(messages.receiverID == userID ? .leading : .trailing)
        .padding(.horizontal, 10)

    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(messages: Message(id: "23",message: "123",receiverID: "123", senderID: "123", timestamp: Date()), userID: "123")
    }
}
