//
//  SignUpViewController.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 09.08.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    let titleLabel = UILabel(text: "Good to see you", font: .avenir26())
    
    let emailLabel = UILabel(text: "Email", font: .avenir20())
    let passwordLabel = UILabel(text: "Password", font: .avenir20())
    let confirmPasswordLabel = UILabel(text: "Confirm password", font: .avenir20())
    
    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, font: .avenir20(), backgroundColor: .black, isShadow: false, cornerRadius: 4)
    
    let alreadyOnBoardLabel = UILabel(text: "Already onboard?", font: .avenir20())
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    let emailTF = TextFieldView(font: .avenir20())
    let passwordTF = TextFieldView(font: .avenir20())
    let confirmPasswordTF = TextFieldView(font: .avenir20())
    
    var authDelegate: AuthDelegate?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signUpButtonTapped() {
        AuthService.shared.signUp(email: emailTF.text, password: passwordTF.text, confirmPassword: confirmPasswordTF.text) { [weak self] result in
            switch result {
            case .success(let user):
                let setupVC = SetupProfileViewController(user: user)
                setupVC.modalPresentationStyle = .fullScreen
                self?.present(setupVC, animated: true, completion: nil)
            case .failure(let error):
                self?.showAlert(title: "NE USHEH", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        dismiss(animated: true) {
            self.authDelegate?.signIn()
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)   
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: Setting Constraints
extension SignUpViewController {
    
    private func setupConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTF])
        emailStackView.axis = .vertical
        emailStackView.spacing = 5
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTF])
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 5
        
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTF])
        confirmPasswordStackView.axis = .vertical
        confirmPasswordStackView.spacing = 5
        
        let stackView = UIStackView(arrangedSubviews: [
            emailStackView,
            passwordStackView,
            confirmPasswordStackView,
            signUpButton
        ])
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        stackView.axis = .vertical
        stackView.spacing = 40
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnBoardLabel, loginButton])
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 10
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
        
    }
}

//MARK: Setup Canvas
import SwiftUI

struct SignUpViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            SignUpViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
