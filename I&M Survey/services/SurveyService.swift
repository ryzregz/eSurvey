//
//  SurveyService.swift
//  I&M Survey
//
//  Created by Eclectics on 25/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import SwiftyJSON
class SurveyService:NSObject,Codable{
      public var survey_id:String?
      public var user_id:String?
      public var answers:JSON?
    
    private enum CodingKeys: String, CodingKey {
        case survey_id
        case user_id
         case answers
    }
    override init() {
    }
    
    init(survey_id: String, user_id: String) {
        self.survey_id = survey_id
        self.user_id = user_id
    }
    
    init(survey_id: String, user_id : String, answers: JSON) {
        self.survey_id = survey_id
        self.user_id = user_id
        self.answers = answers
    }
    
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        survey_id = try container.decodeIfPresent(String.self, forKey: .survey_id)
        user_id = try container.decodeIfPresent(String.self, forKey: .user_id)
        answers = try container.decodeIfPresent(JSON.self, forKey: .answers)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(survey_id , forKey: .survey_id)
         try container.encodeIfPresent(user_id , forKey: .user_id)
         try container.encodeIfPresent(answers , forKey: .answers)
    }
}
