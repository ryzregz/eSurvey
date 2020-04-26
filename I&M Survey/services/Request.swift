//
//  Request.swift
//  I&M Survey
//
//  Created by Eclectics on 25/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import  SwiftyJSON
class Request: NSObject, Codable {
    /// Dictionary object with extension-specific objects.
    public var data:JSON?

    private enum CodingKeys: String, CodingKey {
        case data
    }

    init(data: JSON) {
        self.data = data
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode(JSON.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(data , forKey: .data)
    }
}


