//
//  Embedded.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 20/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import IGListKit

class Embedded: IGListDiffable, SectionControllerProtocol {
    
    var portraits: [Portrait]
    
    init() {
        self.portraits = []
    }
    
    init(events: [Event]) {
        self.portraits = events.map { (item: Event) -> Portrait in
            return Portrait(events: item)
            }
    }
    
    func sectionController() -> IGListSectionController {
        return EmbeddedSectionController()
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self as! NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard let object = object as? Embedded else {
            return false
        }
        
        for (index, portrait) in portraits.enumerated() {
            if !portrait.isEqual(toDiffableObject: object.portraits[index]) {
                return false
            }
        }
        
        return true
    }
}
