//
//  AuthService.swift
//  MDCH
//
//  Created by 123 on 19.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    public static let shared = AuthService()
    
    private init() {}
    
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result , error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            self.generateAndSetUniqueIdentifier { uniqueIdentifier, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                guard let uniqueIdentifier = uniqueIdentifier else {
                    completion(false, nil)
                    return
                }
                
                let db = Firestore.firestore()
                
                db.collection("users")
                    .document(resultUser.uid)
                    .setData([
                        "username": username,
                        "email": email,
                        "uniqueIdentifier": uniqueIdentifier
                    ]) { error in
                        if let error = error {
                            completion(false, error)
                            return
                        }
                        completion(true, nil)
                    }
            }
        }
    }
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    public func addUniqueIdentifierToExistingUsers() {
        let usersCollection = Firestore.firestore().collection("users")
        
        usersCollection.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No users found")
                return
            }
            
            let group = DispatchGroup()
            
            for document in documents {
                var userData = document.data()
                
                if userData["uniqueIdentifier"] == nil {
                    group.enter()
                    
                    self.generateAndSetUniqueIdentifier { uniqueIdentifier, error in
                        if let error = error {
                            print("Error generating unique identifier: \(error.localizedDescription)")
                            group.leave()
                            return
                        }
                        
                        guard let uniqueIdentifier = uniqueIdentifier else {
                            group.leave()
                            return
                        }
                        
                        userData["uniqueIdentifier"] = uniqueIdentifier
                        
                        usersCollection.document(document.documentID).updateData(userData) { error in
                            if let error = error {
                                print("Error updating user \(document.documentID): \(error.localizedDescription)")
                            } else {
                                print("Successfully added unique identifier to user \(document.documentID)")
                            }
                            group.leave()
                        }
                    }
                }
            }
            
            group.notify(queue: .main) {
                print("All users have been processed")
            }
        }
    }
    
    private func generateAndSetUniqueIdentifier(completion: @escaping (String?, Error?) -> Void) {
        let uniqueIdentifiersCollection = Firestore.firestore().collection("uniqueIdentifiers")
        
        func generateUniqueIdentifier() -> String {
            let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<6).map { _ in characters.randomElement()! })
        }
        
        func checkAndSaveIdentifier(_ identifier: String) {
            uniqueIdentifiersCollection.document(identifier).getDocument { (document, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if document?.exists == true {
                    checkAndSaveIdentifier(generateUniqueIdentifier())
                } else {
                    uniqueIdentifiersCollection.document(identifier).setData([:]) { error in
                        if let error = error {
                            completion(nil, error)
                        } else {
                            completion(identifier, nil)
                        }
                    }
                }
            }
        }
        
        checkAndSaveIdentifier(generateUniqueIdentifier())
    }
}


