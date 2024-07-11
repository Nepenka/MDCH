//
//  Message.swift
//  MDCH
//
//  Created by 123 on 10.07.24.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth


struct Message: Equatable {
    let timeMessage: Timestamp
    let indCount: String
    let userId: String
    let username: String
    let avatar: URL?
    
    init(timeMessage: Timestamp, indCount: String, userId: String, username: String, avatar: URL?) {
        self.timeMessage = timeMessage
        self.indCount = indCount
        self.userId = userId
        self.username = username
        self.avatar = avatar
    }
}
