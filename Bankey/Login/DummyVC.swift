//
//  DummyVC.swift
//  Bankey
//
//  Created by Abdallah Mahameed on 8/7/22.
//


import UIKit

protocol DummyVCDelegate: AnyObject{
    func didLogout()
}
class DummyVC: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton(type: .system)
    
    weak var delegate: DummyVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DummyVC {
    func style() {
        view.backgroundColor = .systemBackground // ! dont forget
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Log Out", for: [])
        logoutButton.configuration = .filled()
        logoutButton.addTarget(self, action: #selector(logoutPressed), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
    
    @objc func logoutPressed(_ sender: UIButton) {
        delegate?.didLogout()
    }
}


