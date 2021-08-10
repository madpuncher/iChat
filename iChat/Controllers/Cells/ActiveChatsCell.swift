//
//  ActiveChatsCell.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 09.08.2021.
//

import UIKit

protocol SelfConfigureCell {
    
    static var resudeId: String { get }
    func configure(with value: MChat)
}

class ActiveChatsCell: UICollectionViewCell, SelfConfigureCell {
    
    static var resudeId: String = "ActiveChatsCell"
    
    let friendImage = UIImageView()
    let friendName = UILabel(text: "Friend", font: .laoSangamMN20())
    let friendMessage = UILabel(text: "Message", font: .laoSangamMN18())
    let gradient = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    
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
        friendImage.image = UIImage(named: value.userImageString)
        friendName.text = value.username
        friendMessage.text = value.lastMessage
        gradient.backgroundColor = .black
    }
    
}

//MARK: Setup constraints
extension ActiveChatsCell {
    private func setupConstraints() {
        friendImage.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        friendMessage.translatesAutoresizingMaskIntoConstraints = false
        gradient.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(friendImage)
        self.addSubview(friendName)
        self.addSubview(friendMessage)
        self.addSubview(gradient)
        
        NSLayoutConstraint.activate([
            friendImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImage.heightAnchor.constraint(equalToConstant: 78),
            friendImage.widthAnchor.constraint(equalToConstant: 78),
        ])
        
        NSLayoutConstraint.activate([
            friendName.leadingAnchor.constraint(equalTo: friendImage.trailingAnchor, constant: 16),
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            friendName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            friendMessage.leadingAnchor.constraint(equalTo: friendImage.trailingAnchor, constant: 16),
            friendMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            friendMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)

        ])
        
        NSLayoutConstraint.activate([
            gradient.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradient.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gradient.heightAnchor.constraint(equalToConstant: 78),
            gradient.widthAnchor.constraint(equalToConstant: 8)
        ])

    }
}

//MARK: Setup Canvas
import SwiftUI

struct ActiveChatsCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            MainTabBarController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
