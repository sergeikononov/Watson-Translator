//
//  LanguageList.swift
//  WatsonTranslator
//
//  Created by Сергей on 02/09/2018.
//  Copyright © 2018 Сергей Кононов. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LanguageList{
    let language: String
    let name: String
    
    static func fromJSON(json: [JSON]) -> [LanguageList]? {
        
        return json.compactMap{ jsonItem -> LanguageList in
            let language = jsonItem["language"].string
            let name = jsonItem["name"].string
            
            return LanguageList(language: language!,
                                name: name!)
        }
    }
}

