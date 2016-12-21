//
//  PictureControlerCollectionViewCell.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

protocol Charactable {
    func setup(character: Character)
}

class GridCollectionCell: UICollectionViewCell, NibReusable, Charactable {

    @IBOutlet weak var picture: UIImageView!
    
    static func height() -> CGFloat {
        return 375.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(character: Character) {
        if let thumbImage = character.thumImage {
            self.picture.download(image: (thumbImage.fullPath()))
        }
    }
}
