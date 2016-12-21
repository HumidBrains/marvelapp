//
//  PortraitSectionController.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import IGListKit

class PortraitSectionController: IGListSectionController, IGListSectionType {
    
    var portrait: Portrait!
    var delegate: CharactersDelegate?
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        let width = PortraitCollectionCell.width()
        let height = PortraitCollectionCell.height()
        return CGSize(width: width, height: height)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cellClass: String = PortraitCollectionCell.reuseIdentifier
        
        let cell = collectionContext!.dequeueReusableCell(withNibName: cellClass, bundle: Bundle.main, for: self, at: index)
        
        if let cell = cell as? Eventable{
            cell.setup(event: portrait.object )
        }
        
        return cell
    }
    
    func didUpdate(to object: Any) {
        portrait = object as? Portrait
    }
    
    func didSelectItem(at index: Int) {
   
    }
    
}

