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
    
    // animation
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000

    var logoLabelLeadingAnchor: NSLayoutConstraint?
    var descriptionLabelLeadingAnchor: NSLayoutConstraint?
    
    weak var delegate: LoginVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
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
        logoLabel.alpha = 0
        
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "Your premium source for all things banking"
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.alpha = 0
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
            descriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        descriptionLabelLeadingAnchor = descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        descriptionLabelLeadingAnchor?.isActive = true
        
//       Logo Label
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: logoLabel.bottomAnchor, multiplier: 3),
            logoLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        logoLabelLeadingAnchor = logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        logoLabelLeadingAnchor?.isActive = true
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
            errorlabel.text = "Username or Password is not correct"
            return
        }
        
        if username == "Kevin" && password == "welcome"{
            signinButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        }else{
            errorlabel.isHidden = false
            errorlabel.text = "Username or Password is not correct"
        }
        
    }
}

// MARK: - Animations
extension LoginVC {
    private func animate() {
        
        let duration = 1.0
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.logoLabelLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded() // needed to notify the autolayout that we have changed the view to update it
        }
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.descriptionLabelLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.logoLabel.alpha = 1
            self.descriptionLabel.alpha = 1
        }
        
        
        animator1.startAnimation()
        animator2.startAnimation(afterDelay: 0.3)
        animator3.startAnimation(afterDelay: 0.3)
    }
}
