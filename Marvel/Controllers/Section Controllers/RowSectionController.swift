

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

class RowSectionController: IGListSectionController {
    var row: CharactableView!
    let cells: [String] = [RowCollectionCell.reuseIdentifier]
}

extension RowSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return cells.count
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: RowCollectionCell.height())
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cellClass: String = cells[index]
        
        let cell = collectionContext!.dequeueReusableCell(withNibName: cellClass, bundle: Bundle.main, for: self, at: index)
        
        if let cell = cell as? Charactable{
            cell.setup(character: row.character )
        }
        
        return cell
    }
    
    func didUpdate(to object: Any) {
        row = object as? CharactableView
    }
    
    func didSelectItem(at index: Int) {
        if let vc = self.viewController as? newCharacterViewController {
            vc.showDetailsOf(character: row.character )
        }
    }
}
