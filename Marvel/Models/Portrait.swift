//
//  Portrait.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 20/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import IGListKit

class Portrait: IGListDiffable, SectionControllerProtocol {
    
    var object: Event
    
    init(events: Event) {
        self.object = events
    }
    
    func sectionController() -> IGListSectionController {
        return PortraitSectionController()
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self as! NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        
        guard let object = object as? Event else {
            return false
        }
        
        return self.object.isEqual(toDiffableObject: object)
    }
}
