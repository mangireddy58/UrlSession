//
//  PdfKitController.swift
//  UrlSession
//
//  Created by Mangi on 06/04/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit
import PDFKit

class PdfKitController: UIViewController {

    @IBOutlet weak var pdfBgView: PDFView!
    @IBOutlet weak var thumdnailView: PDFThumbnailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfBgView.displayDirection = .vertical
        pdfBgView.usePageViewController(true)
        pdfBgView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pdfBgView.displayMode = .singlePage
        pdfBgView.autoScales = true
        
        // Load PDF File
        guard let urlStr = URL(string: "https://www.escaux.com/rsrc/EscauxCustomerDocs/DRD_T38Support_AdminGuide/T38_TEST_PAGES.pdf") else {
            return
        }
        do{
            let data = try Data(contentsOf: urlStr)
            pdfBgView.document = PDFDocument(data: data)
        }
        catch let err{
            print(err.localizedDescription)
        }
        
        pdfBgView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        thumdnailView.pdfView = pdfBgView
        thumdnailView.thumbnailSize = CGSize(width: 100, height: 100)
        thumdnailView.layoutMode = .vertical
        thumdnailView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        pdfBgView.autoScales = true
    }
}
