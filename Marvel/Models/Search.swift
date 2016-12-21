//
//  Search.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 20/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import IGListKit

protocol SectionControllerProtocol {
    func sectionController() -> IGListSectionController
}

class Search: IGListDiffable, SectionControllerProtocol {

    let delegate: SearchSectionControllerDelegate?
    
    init(delegate: SearchSectionControllerDelegate) {
        self.delegate = delegate
    }
    
    func sectionController() -> IGListSectionController {
        let controller = SearchSectionController()
        controller.delegate = self.delegate
        return controller
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self as! NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard (object as? Search) != nil else {
            return false
        }
        
        return true
    }
    
}
