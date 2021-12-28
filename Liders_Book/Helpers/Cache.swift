//
//  Cache.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 21/08/21.
//

import Foundation

class Cache{
    
    class func saveUserToken(token:String?){
        UserDefaults.standard.setValue(token, forKey: Keys.isLogged)
    }
    
    class func isUserLogged() -> Bool{
        return UserDefaults.standard.string(forKey: Keys.isLogged) != nil
    }

    class func getUserToken() -> String{
        return UserDefaults.standard.string(forKey: Keys.isLogged)!
    }
}

