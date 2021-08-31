//
//  ReceiverController.swift
//  UrlSession
//
//  Created by Mangi on 23/07/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

class ReceiverController: UIViewController {

    @IBOutlet weak var receivedImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var chooseSideBtn: UIButton!
    
    let light = Notification.Name(rawValue: lightNotificationKey)
    let dark = Notification.Name(rawValue: darkNotificationKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func fnForButtonAction(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            let objController = storyboard?.instantiateViewController(identifier: "SenderController") as! SenderController
            objController.modalPresentationStyle = .fullScreen
            objController.objDelegate = self
            present(objController, animated: true, completion: nil)
        } else {
            let objController = storyboard?.instantiateViewController(withIdentifier: "SenderController") as! SenderController
            objController.objDelegate = self
            present(objController, animated: true, completion: nil)
        }
    }
    
    //MARK:- Create Observers
    func createObservers() {
        //Light
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage), name: light, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabelName), name: light, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: light, object: nil)
        
        //Dark
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage), name: dark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabelName), name: dark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: dark, object: nil)
    }
    
    @objc func updateImage(notification: NSNotification) {
        let isLight = notification.name == dark
        let image = isLight ? UIImage(named: "ReceiptIcon")! : UIImage(named: "BottomEdge")!
        receivedImageView.image = image
    }
    
    @objc func updateLabelName(notification: NSNotification) {
        let isLight = notification.name == dark
        let text = isLight ? "Yellow" : "Mangi"
        nameLbl.text = text
    }
    
    @objc func updateColor(notification: NSNotification) {
        let isLight = notification.name == dark
        let color = isLight ? UIColor.yellow : UIColor.cyan
        view.backgroundColor = color
    }
}

extension ReceiverController: didSendDataToReceiverDelegate {
    func sendDataToReceiver(image: UIImage, name: String, color: UIColor) {
        receivedImageView.image = image
        nameLbl.text = name
        view.backgroundColor = color
    }
}
