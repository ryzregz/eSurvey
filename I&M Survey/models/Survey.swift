//
//  Survey.swift
//  I&M Survey
//
//  Created by Eclectics on 26/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
@objcMembers class Survey:Object,Codable{
    dynamic var id : String?
    dynamic var total_answers : String?
    dynamic  var user_id : String?
    dynamic var survey_id : String?
    dynamic var name: String?
    dynamic var desc: String?
    dynamic var created_at: String?
    dynamic var status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case total_answers
        case user_id
        case survey_id
        case name
        case desc = "description"
        case created_at
        case status
        
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        total_answers = try container.decodeIfPresent(String.self, forKey: .total_answers)
        user_id = try container.decodeIfPresent(String.self, forKey: .user_id)
        survey_id = try container.decodeIfPresent(String.self, forKey: .survey_id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        desc = try container.decodeIfPresent(String.self, forKey: .desc)
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        super.init()
    }
    
    required init()
    {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema)
    {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        super.init(realm: realm, schema: schema)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encodeIfPresent(id , forKey: .id)
        try container.encodeIfPresent(total_answers , forKey: .total_answers)
        try container.encodeIfPresent(user_id , forKey: .user_id)
        try container.encodeIfPresent(survey_id , forKey: .survey_id)
        try container.encodeIfPresent(name , forKey: .name)
        try container.encodeIfPresent(desc , forKey: .desc)
        try container.encodeIfPresent(created_at , forKey: .created_at)
         try container.encodeIfPresent(status , forKey: .status)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

