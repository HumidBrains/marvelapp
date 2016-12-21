//
//  File.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 21/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit

class Event: Mappable {
    var id: Int = 0
    var title: String = ""
    var description: String = ""
    var thumImage: ThumbImage?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        title    <- map["title"]
        description     <- map["description"]
        thumImage    <- map["thumbnail"]
    }
}

extension Event: Equatable {
    static public func ==(rhs: Event, lhs: Event) -> Bool {
        return rhs.id == lhs.id
    }
}

extension Event: IGListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(value: id)
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard let object = object as? Event else {
            return false
        }
        
        return self.id == object.id
    }
}
