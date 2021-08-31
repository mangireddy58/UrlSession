//
//  LinkPreviewController.swift
//  UrlSession
//
//  Created by Mangi on 04/08/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit
import LinkPresentation

@available(iOS 13.0, *)
class LinkPreviewController: UIViewController {

    @IBOutlet weak var linkTxtFld: UITextField!
    @IBOutlet weak var linkPreviewView: UIView!
    @IBOutlet weak var getPreviewBtn: UIButton!
    
    private var linkView : LPLinkView = LPLinkView(metadata: LPLinkMetadata())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLinkViewToContainerView()
        self.getPreviewBtn.tag = 1
    }
    
    private func addLinkViewToContainerView(){
        DispatchQueue.main.async {
            self.linkView.frame = self.linkPreviewView.bounds
            self.linkPreviewView.addSubview(self.linkView)
        }
    }
    
    private func fetchPreview() {
        
        if let textUrl = self.linkTxtFld.text, let url = URL(string: textUrl) {
            
            let metaDataProvider = LPMetadataProvider()
            
            metaDataProvider.startFetchingMetadata(for: url) { [weak self]
                (metaData, error) in
                
                if let error = error {
                    print("Error is:\(error.localizedDescription)")
                }
                else if let metaData = metaData {
                    DispatchQueue.main.async {
                        self?.linkView.metadata = metaData
                    }
                }
            }
        }
    }

    @IBAction func fnForButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            fetchPreview()
            break
        default:
            break
        }
    }
}
