//
//  DataModel.swift
//  EmailModule
//
//  Created by Anton Boyarkin on 22/04/2019.
//

import Foundation

internal struct DataModel: Codable {
    public var title: String?
    public var mailto: String?
    public var subject: String?
    public var message: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "#title"
        case mailto = "#mailto"
        case subject = "#subject"
        case message = "#message"
    }
    
    public init?(map: [String: Any]) {
        self.mapping(map: map)
    }
    
    public mutating func mapping(map: [String: Any]) {
        title = map[CodingKeys.title.rawValue] as? String
        mailto = map[CodingKeys.mailto.rawValue] as? String
        subject = map[CodingKeys.subject.rawValue] as? String
        message = map[CodingKeys.message.rawValue] as? String
    }
}
