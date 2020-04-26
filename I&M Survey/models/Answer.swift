//
//  Answer.swift
//  I&M Survey
//
//  Created by Eclectics on 24/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
class Answer: NSObject,Codable{
    var type : String?
    var option : String?
    
    private enum CodingKeys: String, CodingKey {
        case type
        case option
        
    }
    override init() {
    }
    
     init(type : String, option: String){
        self.type = type
        self.option = option
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        option = try container.decode(String.self, forKey: .option)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type , forKey: .type)
        try container.encode(option , forKey: .option)
    }

}
