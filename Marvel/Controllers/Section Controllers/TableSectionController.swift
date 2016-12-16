

//
//  PictureSectionController.swift
//  Herogram
//
//  Created by Rodrigo Cavalcante on 14/12/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import IGListKit
import Reusable

class TableSectionController: IGListSectionController {
    var character: Character!
}

//TALK: The infrastructure uses each IGListSectionType conforming object as a view model to populate and control cells as part of a section in a UICollectionView
extension TableSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 375, height: 80)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: PictureCollectionCell.reuseIdentifier, bundle: Bundle.main, for: self, at: index)
        
        if let cell = cell as? Charactable{
            cell.setup(character: character)
        }
        
        return cell
    }
    
    func didUpdate(to object: Any) {
        character = object as? Character
    }
    
    func didSelectItem(at index: Int) {
        if let vc = self.viewController as? newCharacterViewController {
            vc.showDetailsOf(character: character)
        }
    }
}
