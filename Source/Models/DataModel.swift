//
//  DataModel.swift
//  EmailModule
//
//  Created by Anton Boyarkin on 22/04/2019.
//

import Foundation
import XMLMapper

internal struct DataModel: Codable, XMLMappable {
    public var title: String?
    public var mailto: String?
    public var subject: String?
    public var message: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case mailto
        case subject
        case message
    }
    
    // XML Mapping
    public var nodeName: String! = "data"
    
    public init?(map: XMLMap) {
        self.mapping(map: map)
    }
    
    public mutating func mapping(map: XMLMap) {
        title <- map["title"]
        mailto <- map["mailto"]
        subject <- map["subject"]
        message <- map["message"]
    }
}
