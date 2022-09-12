//
//  LocalState.swift
//  Bankey
//
//  Created by Abdallah Mahameed on 8/7/22.
//

import Foundation

class LocalState {
    
    static let shared = LocalState()
    
    private enum Keys: String {
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
}
