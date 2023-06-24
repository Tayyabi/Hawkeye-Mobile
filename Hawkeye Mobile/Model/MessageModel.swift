//
//  MessageModel.swift
//  Hawkeye Mobile
//
//  Created by M Tayyab on 20/11/2021.
//

import Foundation

struct MessageModel: Decodable {
    
    //let image_key: String!
    let message: String!
    //let post_id: String!
    let sender: String!
    let timestamp: Int64!
    let type: String!
    
    
    enum CodingKeys: String, CodingKey {
        //case image_key
        case message
        //case post_id
        case sender
        case timestamp
        case type
    }
    
    init() {
        //self.image_key = ""
        self.message = ""
        //self.post_id = ""
        self.sender = ""
        self.timestamp = 0
        self.type = ""
    }
    init(message message: String, sender sender: String,timestamp timestamp: Int64, type type: String) {
        //self.image_key = imagekey
        self.message = message
        //self.post_id = postid
        self.sender = sender
        self.timestamp = timestamp
        self.type = type
        
    }
    
    
}
