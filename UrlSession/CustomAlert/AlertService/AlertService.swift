//
//  AlertService.swift
//  UrlSession
//
//  Created by Mangi on 31/08/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

class AlertService {
    
    
    func alert(title: String, body: String, buttonTitle: String, confirmCompletion: @escaping () -> Void, cancelCompletion: @escaping () -> ()) -> AlertViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        
        alertVC.alertTitle = title
        
        alertVC.alertBody = body
        
        alertVC.actionButtonTitle = buttonTitle
        
        alertVC.buttonAction = confirmCompletion
        
        alertVC.cancelButtonAction = cancelCompletion

        alertVC.isTapGestureisOn = false
        
        return alertVC
    }
}
