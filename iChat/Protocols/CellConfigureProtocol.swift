//
//  CellConfigureProtocol.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 10.08.2021.
//

import Foundation

protocol SelfConfigureCell {
    static var resudeId: String { get }
    func configure(with value: MChat)
}
