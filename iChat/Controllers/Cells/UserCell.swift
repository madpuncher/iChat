//
//  UserCell.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 12.08.2021.
//

import UIKit

class UserCell: UICollectionViewCell, SelfConfigureCell {
    
    var userImage = UIImageView()
    var userName = UILabel(text: "NAME", font: .laoSangamMN20())
    var container = UIView()
    
    static var resudeId: String = "UserCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        
        backgroundColor = .white
        
        self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.container.layer.cornerRadius = 4
        self.container.clipsToBounds = true
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let user = value as? MUser else { return }
        userImage.image = UIImage(named: user.avatarStringURL)
        userName.text = user.username
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
                
        container.translatesAutoresizingMaskIntoConstraints = false
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
    
        self.addSubview(container)
        container.addSubview(userName)
        container.addSubview(userImage)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: self.topAnchor),
            userImage.heightAnchor.constraint(equalTo: container.widthAnchor),
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userName.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            userName.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor)
        ])
        
    }
    
}

//MARK: Setup Canvas
import SwiftUI

struct UserCellProvider: PreviewProvider {
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
