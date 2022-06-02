//
//  Preferences.swift
//  Asterisk
//
//  Created by Adrian Richton Co on 6/2/22.
//

import Foundation

struct Preferences {
    
    var appUserData: AppUserData?
    
    mutating func emotionInput(emotion: String){
        appUserData = AppUserData(emotion: emotion)
    }
    
    func userEmotion() -> String {
        return appUserData?.emotion ?? "No data"
    }
    
}
