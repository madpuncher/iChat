//
//  LoginViewController.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 09.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Welcome back!", font: .avenir26())
    
    let googleLabel = UILabel(text: "Login with", font: .avenir20())
    
    let googleButton = UIButton(title: "Google", titleColor: .black, font: .avenir20(), backgroundColor: .white, isShadow: true, cornerRadius: 4)
    
    let orLabel = UILabel(text: "or", font: .avenir20())
    
    let emailLabel = UILabel(text: "Email", font: .avenir20())
    
    let passwordLabel = UILabel(text: "Password", font: .avenir20())
    
    let loginButton = UIButton(title: "Login", titleColor: .white, font: .avenir20(), backgroundColor: .black, isShadow: false, cornerRadius: 4)
    
    let needAccountLabel = UILabel(text: "Need an account?", font: .avenir20())
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    let emailTF = TextFieldView(font: .laoSangamMN20())
    let passwordTF = TextFieldView(font: .laoSangamMN20())
        
    var authDelegate: AuthDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        
        googleButton.addGoogleImage()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        AuthService.shared.signIn(email: emailTF.text, password: passwordTF.text) { [weak self ] result in
            switch result {
            case .success(_):
                self?.showAlert(title: "USPEH", message: "REGISTER")
            case .failure(let error):
                self?.showAlert(title: "NE USHEH", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func signUpButtonTapped() {
        dismiss(animated: true) {
            self.authDelegate?.signUp()
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController {
    
    private func setupConstraints() {
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let googleTF = ButtonLabelView(label: googleLabel, button: googleButton)
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTF])
        emailStackView.axis = .vertical
        emailStackView.spacing = 10
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTF])
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [
            googleTF,
            orLabel,
            emailStackView,
            passwordStackView,
            loginButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 40
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [
            needAccountLabel,
            signUpButton
        ])
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 10
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
        
    }
}

//MARK: Setup Canvas
import SwiftUI

struct LoginViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            LoginViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
