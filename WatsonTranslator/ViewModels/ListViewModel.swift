//
//  ListViewModel.swift
//  WatsonTranslator
//
//  Created by Сергей on 02/09/2018.
//  Copyright © 2018 Сергей Кононов. All rights reserved.
//

import Foundation

class ListViewModel {
    var languages: String
    var key: String
    
    
    init(list: LanguageList) {
        self.languages = list.name
        self.key = list.language
    }
    
}
