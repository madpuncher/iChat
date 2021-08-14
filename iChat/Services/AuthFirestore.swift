//
//  AuthFirestore.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 14.08.2021.
//

import Firebase
import FirebaseFirestore

class AuthFirestore {
    
    static let shared = AuthFirestore()
    
    let db = Firestore.firestore()
    
    private var userRef: CollectionReference {
        return db.collection("users")
    }
    
    func saveProfile(id: String, email: String, username: String?, avatarImageString: String?, description: String, sex: String, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        guard Validator.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(AuthUserError.notFilled))
            return
        }
        
        let user = MUser(username: username!, email: email, avatarStringURL: "not exist", description: description, sex: sex, id: id)
            
        self.userRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
}
