//
//  DetailViewController.swift
//  WatsonTranslator
//
//  Created by Сергей on 02/09/2018.
//  Copyright © 2018 Сергей Кононов. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var currentText: UITextView!
    @IBOutlet weak var currentLanguage: UILabel!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var translatedLanguage: UILabel!
    
    var result: HistoryModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentLanguage.text = result.currentLanguage
        currentText.text = result.currentText
        translatedText.text = result.translatedText
        translatedLanguage.text = result.translatedLanguage

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
