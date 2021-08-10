//
//  WaitingChatCell.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 10.08.2021.
//

import UIKit

class WaitingChatCell: UICollectionViewCell, SelfConfigureCell {
    
    let requestFriendImage = UIImageView()
    
    static var resudeId: String = "WaitingChatCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with value: MChat) {
        requestFriendImage.image = UIImage(named: value.userImageString)
    }
    
    private func setupConstraints() {
        
        requestFriendImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(requestFriendImage)
        
        NSLayoutConstraint.activate([
            requestFriendImage.topAnchor.constraint(equalTo: self.topAnchor),
            requestFriendImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            requestFriendImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            requestFriendImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
}
