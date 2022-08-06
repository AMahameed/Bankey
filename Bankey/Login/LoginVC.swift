//
//  ViewController.swift
//  Bankey
//
//  Created by Abdallah Mahameed on 7/4/22.
//

import UIKit

protocol LoginVCDelegate: AnyObject {
    func didLogin()
}

class LoginVC: UIViewController {
    
    let loginView = LoginView()
    let signinButton = UIButton(type: .system)
    let errorlabel = UILabel()
    let logoLabel = UILabel()
    let descriptionLabel = UILabel()
    private var username: String?{
        return loginView.usernameTextField.text
    }
    private var password: String?{
        return loginView.passwordTextField.text
    }
    
    weak var delegate: LoginVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signinButton.configuration?.showsActivityIndicator = false  
    }
}

extension LoginVC{
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        signinButton.configuration = .filled()
        signinButton.configuration?.imagePadding = 8
        signinButton.setTitle("Sign In ", for: [])
        signinButton.addTarget(self, action: #selector(signinTapped), for: .primaryActionTriggered)
        
        errorlabel.translatesAutoresizingMaskIntoConstraints = false
        errorlabel.textAlignment = .center
        errorlabel.textColor = .systemRed
        errorlabel.numberOfLines = 0
        errorlabel.isHidden = true
        //
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.textAlignment = .center
        logoLabel.text = "Bankey"
        logoLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        logoLabel.textColor = .black
        logoLabel.numberOfLines = 0
        
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "Your premium source for all things banking"
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signinButton)
        view.addSubview(errorlabel)
        view.addSubview(descriptionLabel)
        view.addSubview(logoLabel)
        
        
    
//       Login View
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2)
        ])
        
//       Button
        NSLayoutConstraint.activate([
            signinButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 4),
            signinButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signinButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
//       Error Label
        NSLayoutConstraint.activate([
            errorlabel.topAnchor.constraint(equalToSystemSpacingBelow: signinButton.bottomAnchor, multiplier: 2),
            errorlabel.leadingAnchor.constraint(equalTo: signinButton.leadingAnchor),
            errorlabel.trailingAnchor.constraint(equalTo: signinButton.trailingAnchor)
        ])
        
//       Description Label
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: signinButton.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: signinButton.trailingAnchor)
        ])
        
//       Logo Label
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: logoLabel.bottomAnchor, multiplier: 2),
            logoLabel.leadingAnchor.constraint(equalTo: signinButton.leadingAnchor),
            logoLabel.trailingAnchor.constraint(equalTo: signinButton.trailingAnchor)
        ])
    }
}

extension LoginVC{
    
    @objc func signinTapped(sender: UIButton){
        errorlabel.isHidden = true
        login()
    }
    
    private func login() {
        
        guard let username = username, let password = password, !username.isEmpty, !password.isEmpty else {
            errorlabel.isHidden = false
            errorlabel.text = "Username/Password is not correct"
            return
        }
        
        if username == "Kevin" && password == "welcome"{
            signinButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        }else{
            errorlabel.isHidden = false
            errorlabel.text = "Username/Password is not correct"
        }
        
    }
}
