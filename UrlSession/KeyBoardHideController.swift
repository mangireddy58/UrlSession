//
//  KeyBoardHideController.swift
//  UrlSession
//
//  Created by Mangi on 08/07/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

class KeyBoardHideController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstTxtFld: UITextField!
    @IBOutlet weak var txtFld: UITextField!
    @IBOutlet weak var bootmLbl: UIButton!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyBoardHide))
        view.addGestureRecognizer(tap)
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyBoardHide(){
        txtFld.resignFirstResponder()
        firstTxtFld.resignFirstResponder()
    }
    
    @objc func keyBoardWillChange(notification: Notification){
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        }
        else{
            view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyBoardHide()
        return true
    }
}
