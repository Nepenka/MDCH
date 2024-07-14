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
        let description: String
        let theme: String
        let timestamp: Timestamp
        var likedBy: [String]
        var likes: Int {
         likedBy.count
        }

        
    init(postId: String, userId: String, userName: String, avatarURL: String, description: String, theme: String, timestamp: Timestamp, likedBy: [String]) {
            self.postId = postId
            self.userId = userId
            self.userName = userName
            self.avatarURL = avatarURL
            self.description = description
            self.theme = theme
            self.timestamp = timestamp
            self.likedBy = likedBy
        }
}
