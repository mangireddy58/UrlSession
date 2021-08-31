//
//  KeyBoardHideController.swift
//  UrlSession
//
//  Created by Mangi on 08/07/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

class KeyBoardHideController1: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstTxtFld: UITextField!
    @IBOutlet weak var txtFld: UITextField!
    @IBOutlet weak var bootmLbl: UIButton!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyBoardHide))
        view.addGestureRecognizer(tap)
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChangeNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHideNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardHide(){
        txtFld.resignFirstResponder()
        firstTxtFld.resignFirstResponder()
    }
    
    @objc func keyBoardWillChangeNotification(notification: Notification){
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            UIView.animate(withDuration: 0.5) {
                self.bottomConst.constant = height
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyBoardWillHideNotification(notification: Notification){
        UIView.animate(withDuration: 0.5) {
            self.bottomConst.constant = 20
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyBoardHide()
        return true
    }
}
