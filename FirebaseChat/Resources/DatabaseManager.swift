//
//  DatabaseManager.swift
//  FirebaseChat
//
//  Created by MacBook Noob on 10/02/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

// MARK: - Account Manager

extension DatabaseManager {
    public func isUserExistWith(email: String, completion: @escaping((Bool) -> Void)) {
        let safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: DataEventType.value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    /// Insert new user to the database
    public func insertUserwWith(user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "First Name": user.firstName,
            "Last Name": user.lastName
            ]
        )
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        let safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
//    let profilePicURL: String
}
