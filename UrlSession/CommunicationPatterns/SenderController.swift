//
//  SenderController.swift
//  UrlSession
//
//  Created by Mangi on 23/07/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

let lightNotificationKey = "com.urssession.light"
let darkNotificationKey = "com.urssession.dark"

protocol didSendDataToReceiverDelegate {
    func sendDataToReceiver(image: UIImage, name: String, color: UIColor)
}

class SenderController: UIViewController {

    
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    
    var objDelegate: didSendDataToReceiverDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstBtn.tag = 1
        secondBtn.tag = 2
    }

    @IBAction func fnForButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            //Using Delegate
//            objDelegate.sendDataToReceiver(image: UIImage(named: "ReceiptIcon")!, name: "Yellow", color: .yellow)
            
            //Notification Center
            let name = Notification.Name(rawValue: darkNotificationKey)
            NotificationCenter.default.post(name: name, object: nil)
            
            dismiss(animated: true, completion: nil)
        case 2:
            //Using Delegate
//            objDelegate.sendDataToReceiver(image: UIImage(named: "BottomEdge")!, name: "Mangi", color: .brown)
            
            //Notification Center
            let name = Notification.Name(rawValue: lightNotificationKey)
            NotificationCenter.default.post(name: name, object: nil)
            
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
}
