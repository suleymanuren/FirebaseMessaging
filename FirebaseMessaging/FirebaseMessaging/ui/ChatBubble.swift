//
//  ChatBubble.swift
//  FirebaseMessaging
//
//  Created by Bulut Sistem on 7.07.2023.
//

import SwiftUI

struct ChatBubble: View {
    @StateObject private var messageService = MessageService()
    @State private var showTime = false
    let userID : String
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                ForEach ( messageService.messages) { messages in
                    if messages.senderID == userID {
                        VStack(alignment: .trailing) {
                            HStack{
                                Text(messages.message)
                                    .padding()
                                    .cornerRadius(12)
                                    .background(Color(.systemGreen))
                                    .clipShape(ChatBubbleRadius(isFromSender: true))
                                Image("sender")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .onTapGesture {
                                showTime.toggle()
                            }
                            if showTime {
                                Text("\(messages.timestamp.formatted(.dateTime.hour().minute()))")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 25)
                            }
                        }.padding(.trailing,12)
                        
                    }else {
                        VStack(alignment: .leading) {
                            HStack{
                                Image("receiver")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                Text(messages.message)
                                    .padding()
                                    .cornerRadius(12)
                                    .background(Color(.systemGray5))
                                    .clipShape(ChatBubbleRadius(isFromSender: false))
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                showTime.toggle()
                            }
                            if showTime {
                                Text("\(messages.timestamp.formatted(.dateTime.hour().minute()))")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 25)
                            }
                        }.padding(.leading,12)
                    }
                    
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
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(userID: "123")
    }
}
