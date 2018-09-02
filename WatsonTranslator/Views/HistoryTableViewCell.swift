//
//  HistoryTableViewCell.swift
//  WatsonTranslator
//
//  Created by Сергей on 02/09/2018.
//  Copyright © 2018 Сергей Кононов. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var currentTextView: UITextView!
    @IBOutlet weak var currentLanguage: UILabel!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var translatedLanguage: UILabel!
    
    func setup(model: HistoryModel) {
        currentTextView.text = model.currentText
        currentLanguage.text = model.currentLanguage
        translatedText.text = model.translatedText
        translatedLanguage.text = model.translatedLanguage
    }
    

}
