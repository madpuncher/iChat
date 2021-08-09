//
//  SetupProfileViewController.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 09.08.2021.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    let addPhotoView = AddPhotoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        addPhotoView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addPhotoView)
        
        NSLayoutConstraint.activate([
            addPhotoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            addPhotoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

//MARK: Setup Canvas
import SwiftUI

struct SetupProfileViewControllerProvider: PreviewProvider {
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

