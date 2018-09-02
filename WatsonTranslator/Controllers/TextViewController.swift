//
//  TextViewController.swift
//  WatsonTranslator
//
//  Created by Сергей on 02/09/2018.
//  Copyright © 2018 Сергей Кононов. All rights reserved.
//

import UIKit
import CoreData

class TextViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    

    @IBOutlet weak var textVIew: UITextView!
    @IBOutlet weak var languagePickerView: UIPickerView!
    @IBOutlet weak var button: UIButton!
    
    var languages = [ListViewModel]()
    var result: HistoryModel!
    var check = HistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 15
        fetchData()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].languages
    }
    
    
    fileprivate func fetchData() {
        NetworkManager.shared.getLanguageList(success: { (value) in
            self.languages = value?.map({ return ListViewModel(list: $0)}) ?? []
            self.languagePickerView.reloadAllComponents()
        }) { (err) in
            showAlertWithOk(self, title: "Error", message: err)
        }
    }
    
    
    @IBAction func sendText(_ sender: UIButton) {
        NetworkManager.shared.identy(text: textVIew.text!, success: { (language) in
            NetworkManager.shared.translate(text: self.textVIew.text!, source: language!, target: self.languages[self.languagePickerView.selectedRow(inComponent: 0)].key, success: { (text) in
                self.result = HistoryModel(currentText: self.textVIew.text!,
                                         currentLanguage: language!,
                                         translatedText: text!, translatedLanguage: self.languages[self.languagePickerView.selectedRow(inComponent: 0)].key)
                
                self.check.saveToCD(name: self.result)
                self.performSegue(withIdentifier: "send", sender: self.result)
                
            }, failure: { (err) in
                showAlertWithOk(self, title: "Error", message: err)
            })
        }) { (err) in
            showAlertWithOk(self, title: "Error", message: err)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "send") {
            let secondViewController = segue.destination as? DetailViewController
            self.result = sender as! HistoryModel
            secondViewController?.result = self.result
        }
    }

}
