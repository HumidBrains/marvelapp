//
//  PortraitCollectionCell.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

protocol Eventable {
    func setup(event: Event)
}

class PortraitCollectionCell: UICollectionViewCell, NibReusable, Eventable {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    static func height() -> Double {
        return 140.0
    }
    
    static func width() -> Double {
        return 120.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(event: Event) {
        if let thumbImage = event.thumImage {
            self.picture.download(image: (thumbImage.fullPath()))
            self.name.text = event.title
        }
    }
    
}
