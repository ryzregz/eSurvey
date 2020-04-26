//
//  Auth.swift
//  I&M Survey
//
//  Created by Eclectics on 25/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
class AuthService:NSObject, Codable{
    public var phone_number:String?
    public var password:String?
    public var email :String?
    public var firstname:String?
    public var lastname:String?
    public var id_number:String?
    public var profile_image:String?
    private enum CodingKeys: String, CodingKey {
        case phone_number
        case password
        case email
        case firstname
        case lastname
        case id_number
        case profile_image
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    init(firstname:String,lastname:String,email: String, password: String,phone_number:String,id_number:String, profile_image: String) {
        self.phone_number = phone_number
        self.email = email
        self.lastname = lastname
        self.firstname = firstname
        self.id_number = id_number
        self.password = password
        self.profile_image = profile_image
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number)
        lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
        firstname = try container.decodeIfPresent(String.self, forKey: .firstname)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        id_number = try container.decodeIfPresent(String.self, forKey: .id_number)
        profile_image = try container.decodeIfPresent(String.self, forKey: .profile_image)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(phone_number , forKey: .phone_number)
        try container.encodeIfPresent(lastname , forKey: .lastname)
        try container.encodeIfPresent(firstname , forKey: .firstname)
        try container.encodeIfPresent(password , forKey: .password)
        try container.encodeIfPresent(email , forKey: .email)
        try container.encodeIfPresent(id_number , forKey: .id_number)
         try container.encodeIfPresent(profile_image , forKey: .profile_image)
    }
}
