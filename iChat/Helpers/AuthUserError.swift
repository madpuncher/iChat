//
//  AuthUserError.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 14.08.2021.
//

import Foundation

enum AuthUserError {
    case notFilled
    case photoNotExist
}

extension AuthUserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Некорректная фотография", comment: "")
        }
    }
}
