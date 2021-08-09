//
//  AddPhotoView.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 09.08.2021.
//

import UIKit

class AddPhotoView: UIView {
    
    let photoImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "avatar")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 1
        return image
    }()
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(photoImage)
        self.addSubview(addPhotoButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            photoImage.heightAnchor.constraint(equalToConstant: 100),
            photoImage.widthAnchor.constraint(equalToConstant: 100),
            photoImage.topAnchor.constraint(equalTo: self.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoButton.heightAnchor.constraint(equalToConstant: 30),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 30),
            addPhotoButton.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor, constant: 15),
            addPhotoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.bottomAnchor.constraint(equalTo: photoImage.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: addPhotoButton.trailingAnchor).isActive = true

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImage.layer.masksToBounds = true
        photoImage.layer.cornerRadius = photoImage.frame.height / 2
    }
}

//MARK: Setup Canvas
import SwiftUI

struct SetupViewProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            SetupProfileViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
