
//
//  Row.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 20/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import IGListKit

class CharactableView: IGListDiffable, SectionControllerProtocol {
    var character: Character
    var viewType: SectionController = .row
    
    init(character: Character, sectionController: SectionController) {
        self.character = character
        self.viewType = sectionController
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return "\(viewType)\(self.character.diffIdentifier())" as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        
        guard let object = object as? Character else {
            return false
        }
        
        return character.isEqual(toDiffableObject: object)
    }
    
    func sectionController() -> IGListSectionController {
        switch viewType {
        case .grid:
            return GridSectionController()
        case .row:
            return RowSectionController()
        }
    }
}
