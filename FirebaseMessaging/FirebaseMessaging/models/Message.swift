//
//  Message.swift
//  FirebaseMessaging
//
//  Created by Bulut Sistem on 7.07.2023.
//

import SwiftUI

struct Message : Identifiable, Codable {
    
    var id : String
    var message : String
    var receiverID : String
    var senderID : String
    var timestamp : Date
    
}
