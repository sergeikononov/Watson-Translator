//
//  NetworkManager.swift
//  WatsonTranslator
//
//  Created by Сергей on 02/09/2018.
//  Copyright © 2018 Сергей Кононов. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    static let shared = NetworkManager()
    
    
    private var username: String = "6987a48d-342e-4a69-8adc-e65b1cc0b9da"
    private var password: String = "MxYSIi6nQP2Y"
    private var url: String = "https://gateway.watsonplatform.net/language-translator/api/"
    private var headers: HTTPHeaders = [:]
    
    func getHeaders() {
        if let authorizationHeader = Request.authorizationHeader(user: self.username, password: self.password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
    }
    
    func getLanguageList(success: @escaping (_ value: [LanguageList]?) -> Void = {_ in }, failure: @escaping (_ message: String) -> Void = {_ in }) {

        Alamofire.request(url + "v3/identifiable_languages?version=2018-05-01", method: .get, headers: headers).responseJSON { response in
            
            guard let value = response.value else {
                return
            }
            
            let json = JSON(value)
            
            if response.response!.statusCode == 200 {
                success(LanguageList.fromJSON(json: json["languages"].arrayValue))
            }
            else {
                failure("error")
            }
            
        }
    }
    
    
    func identy(text: String, success: @escaping (_ value: String?) -> Void = {_ in }, failure: @escaping (_ message: String) -> Void = {_ in }) {
        
        let parameters = ["text": text] as [String : Any]
        
        Alamofire.request(url + "v2/identify", method: .get, parameters: parameters, headers: headers)
            .responseString { (value) in
                success(value.value)
        }
    }
    
    func translate(text: String, source: String, target: String, success: @escaping (_ value: String?) -> Void = {_ in }, failure: @escaping (_ message: String) -> Void = {_ in }) {
        
        let parameters = ["source": source,
                          "target": target,
                          "text": text] as [String : Any]
        
        Alamofire.request(url + "v2/translate", method: .get, parameters: parameters, headers: headers)
            .responseString { (value) in
                if value.value!.first == "{" {
                    return
                }
                success(value.value)
            }
            .responseJSON { (response) in
                guard let value = response.value else {
                    return
                }
                let json = JSON(value)
                failure(json["error_message"].string!)
        }
        
        
    }
    
}
