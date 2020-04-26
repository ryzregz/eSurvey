//
//  Question.swift
//  I&M Survey
//
//  Created by Eclectics on 25/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
@objcMembers class Question:Object,Codable{
   dynamic var id : String?
   dynamic var type : String?
   dynamic  var question : String?
   dynamic var survey_id : String?
    
     enum CodingKeys: String, CodingKey {
        case id
        case type
        case question
        case survey_id
        
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
         id = try container.decodeIfPresent(String.self, forKey: .id)
         type = try container.decodeIfPresent(String.self, forKey: .type)
         question = try container.decodeIfPresent(String.self, forKey: .question)
         survey_id = try container.decodeIfPresent(String.self, forKey: .survey_id)
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
        try container.encodeIfPresent(type , forKey: .type)
         try container.encodeIfPresent(question , forKey: .question)
         try container.encodeIfPresent(survey_id , forKey: .survey_id)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

