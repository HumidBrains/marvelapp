//
//  ThumbImage.swift
//  Marvel
//
//  Created by Thiago Lioy on 17/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import ObjectMapper


struct ThumbImage {
    var path: String = ""
    var imageExtension: String = ""
    
    func fullPath() -> String {
        return "\(path).\(imageExtension)"
    }
    
    init() {
        path = "https://lh4.googleusercontent.com/-YsbRpTbPHBY/AAAAAAAAAAI/AAAAAAAAAAA/-VswE3XagAc/s128-c-k/photo"
        imageExtension = "jpg"
    }
    
}

extension ThumbImage: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        path    <- map["path"]
        imageExtension    <- map["extension"]
    }
}
