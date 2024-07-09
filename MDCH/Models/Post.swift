//
//  Post.swift
//  MDCH
//
//  Created by 123 on 7.07.24.
//

import Foundation
import UIKit
import Firebase



struct Post: Equatable {
    let postId: String
    let userId: String
    let userName: String
    let avatarURL: String
    let timestamp: Timestamp
    
    init(postId: String, userId: String, userName: String, timestamp: Timestamp, avatarURL: String) {
        self.postId = postId
        self.userId = userId
        self.userName = userName
        self.timestamp = timestamp
        self.avatarURL = avatarURL
    }
}
