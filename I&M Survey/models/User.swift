//
//  AuthModel.swift
//  I&M Survey
//
//  Created by Morris on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import RealmSwift
class User:Object{
    dynamic var _UserId = 0
    dynamic var _UserPhone:String?
    dynamic var _UserFirstName:String?
    dynamic var _UserLastName:String?
    dynamic var _Password:String?
    dynamic var _Thumb:String?
    dynamic var _Email:String?

    var UserId :Int{
        get{ return _UserId}
        set{_UserId = newValue}
    }
    
  

    //
    var UserPhoneNumber :String{
        get{ return _UserPhone!}
        set{_UserPhone = newValue}
    }
    
    var UserFirstName :String{
        get{ return _UserFirstName!}
        set{_UserFirstName = newValue}
    }
    //
    
    var UserLastName :String{
        get{ return _UserLastName!}
        set{_UserLastName = newValue}
    }
    //
    var UserPassword :String{
        get{ return _Password!}
        set{_Password = newValue}
    }
    //
    //
    var Thumb :String{
        get{ return _Thumb!}
        set{_Thumb = newValue}
    }
    //
    var Email :String{
        get{ return _Email!}
        set{_Email = newValue}
    }
 
    
    override func isEqual(_ object: Any?) -> Bool {
        guard object is User else {
            return false
        }
        let auth = object as! User
        
        return auth._UserId == self.UserId && auth._Email == self.Email && auth._Password == self.UserPassword &&
           auth._UserFirstName == self.UserFirstName && auth._UserLastName == self.UserLastName && auth._UserPhone == self._UserPhone && auth._Thumb == self.Thumb
    }
    
}
