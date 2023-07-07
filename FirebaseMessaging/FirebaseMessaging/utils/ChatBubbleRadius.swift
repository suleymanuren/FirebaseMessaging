//
//  ChatBubbleRadius.swift
//  FirebaseMessaging
//
//  Created by Bulut Sistem on 7.07.2023.
//

import SwiftUI

struct ChatBubbleRadius: Shape {
    let isFromSender: Bool
    
        func path(in rect : CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [
                .topLeft,
                .topRight,
                isFromSender ? .bottomLeft : .bottomRight
            ],
            cornerRadii: CGSize(width: 16, height: 16))
            return Path(path.cgPath)
        
        }
}


struct ChatBubbleRadius_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubbleRadius(isFromSender: true)
    }
}

