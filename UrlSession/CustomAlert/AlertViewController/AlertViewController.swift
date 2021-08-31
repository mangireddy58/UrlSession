//
//  AlertViewController.swift
//  UrlSession
//
//  Created by Mangi on 31/08/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    var alertTitle = String()
    
    var alertBody = String()
    
    var actionButtonTitle = String()
    
    var isTapGestureisOn = false
    
    var buttonAction: (() -> Void)?
    var cancelButtonAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        titleLabel.text = alertTitle
        bodyLabel.text = alertBody
        actionButton.setTitle(actionButtonTitle, for: .normal)
        
        if isTapGestureisOn {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeAlert))
            self.view.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func removeAlert() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
        cancelButtonAction?()
    }
    
    @IBAction func didTapActionButton(_ sender: Any) {
        dismiss(animated: true)
        buttonAction?()
    }
    
    
}
