//
//  Extensions.swift
//  WatsonTranslator
//
//  Created by Сергей on 02/09/2018.
//  Copyright © 2018 Сергей Кононов. All rights reserved.
//

import Foundation
import UIKit


func showAlertWithOk(_ owner: UIViewController, title: String, message: String) {
    let alert  = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    owner.present(alert, animated: true, completion: nil)
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
