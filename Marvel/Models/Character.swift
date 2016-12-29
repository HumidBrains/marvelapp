//
//  Character.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit

//TALK: change to class due IGListDiffable protocol
class Character: Mappable {
    var id: Int = 0
    var name: String = ""
    var bio: String = ""
    var thumImage: ThumbImage?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        name    <- map["name"]
        bio     <- map["description"]
        thumImage    <- map["thumbnail"]
    }
}

extension Character: Equatable {
    static public func ==(rhs: Character, lhs: Character) -> Bool {
        return rhs.id == lhs.id
    }
}

extension Character: IGListDiffable {
    
    //TALK: unique id (identifies the object)
    public func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(value: id)
    }
    
    //TALK: should perform the same type of check as isEqual:, but without impacting performance characteristics like in Objective-C containers such as NSDictionary and NSSet.
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard let object = object as? Character else {
            return false
        }
        
        if id != object.id || name != object.name {
            return false
        }
        
        return self == object
    }
}
