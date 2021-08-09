//
//  SetupProfileViewController.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 09.08.2021.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    let addPhotoView = AddPhotoView()
    
    let setupLabel = UILabel(text: "Set up profile", font: .avenir26())

    let fullNameLabel = UILabel(text: "Full name", font: .avenir20())

    let aboutMeLabel = UILabel(text: "About me", font: .avenir20())
    
    let sexLabel = UILabel(text: "Sex", font: .avenir20())
    
    let sexSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.insertSegment(withTitle: "Male", at: 0, animated: true)
        control.insertSegment(withTitle: "Female", at: 1, animated: true)
        control.selectedSegmentIndex = 0
        return control
    }()
    
    let goToChatsButton = UIButton(title: "Go to chats", titleColor: .white, font: .avenir20(), backgroundColor: .black, isShadow: false, cornerRadius: 4)
    
    let fullNameTF = TextFieldView(font: .avenir20())
    let aboutMeTF = TextFieldView(font: .avenir20())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        addPhotoView.translatesAutoresizingMaskIntoConstraints = false
        setupLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addPhotoView)
        view.addSubview(setupLabel)
        
        NSLayoutConstraint.activate([
            setupLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            setupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoView.topAnchor.constraint(equalTo: setupLabel.bottomAnchor, constant: 40),
            addPhotoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTF])
        fullNameStackView.axis = .vertical
        
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTF])
        aboutMeStackView.axis = .vertical

        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl])
        sexStackView.axis = .vertical
        sexStackView.spacing = 10

        goToChatsButton.translatesAutoresizingMaskIntoConstraints = false
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [
            fullNameStackView,
            aboutMeStackView,
            sexStackView,
            goToChatsButton,
        ])
        stackView.axis = .vertical
        stackView.spacing = 40
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: addPhotoView.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
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

