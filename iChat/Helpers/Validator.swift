//
//  Validator.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 13.08.2021.
//

import Foundation

class Validator {
    
    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard
            let email = email,
            let password = password,
            let confirmPassword = confirmPassword,
            email != "",
            password != "",
            confirmPassword != "" else {
            return false
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
