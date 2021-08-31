//
//  Alert.swift
//  UrlSession
//
//  Created by Mangi on 22/07/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    //MARK:- Basic Alert Controller
    class func showBasicAlert(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    
}
