//
//  AppDelegate.swift
//  Bankey
//
//  Created by Abdallah Mahameed on 7/4/22.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let loginVC = LoginVC()
    let onboardingContainerVC = OnboardingContainerVC()
    let dummyVC = DummyVC()
    let mainVC = MainVC()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = AccountSummaryVC()
        mainVC.selectedIndex = 1 // it tells the mainVC that choose the tab that has the Tag = 1
        loginVC.delegate = self
        onboardingContainerVC.delegate = self
        dummyVC.delegate = self
        return true
    }
}

extension AppDelegate: LoginVCDelegate{
    func didLogin() {
        if LocalState.shared.hasOnboarded{ // reads to user defaults
            setRootViewController(dummyVC)
        }else{
            setRootViewController(onboardingContainerVC)
        }
    }
}

extension AppDelegate: OnboardingContainerVCDelegate{
    func didFinishOnboarding() {
        LocalState.shared.hasOnboarded = true // sets to user defaults
        setRootViewController(dummyVC)
    }
}

extension AppDelegate: DummyVCDelegate{
    func didLogout() {
        setRootViewController(loginVC)
    }
}

extension AppDelegate{
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
