//
//  SharingImageTextController.swift
//  UrlSession
//
//  Created by Mangi on 19/07/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

class SharingImageTextController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory")
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
    }
    
    //MARK:- FUNCTION FOR GET DIRECTORY PATH
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    //MARK:- SAVE IMAGE IN DOCUMENT DIRECTORY
    
    func saveImageDocumentDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
        let image = UIImage(named: "apple.jpg")
        print(paths)
        let imageData = image!.jpegData(compressionQuality: 0.5);
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    @IBAction func shareImageTextAction(_ sender: Any) {
        createDirectory ()
        saveImageDocumentDirectory()
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent("apple.jpg")
        if fileManager.fileExists(atPath: imagePath){

        }else{
            print("No Image")
        }
        let imageToShare = [UIImage(contentsOfFile: imagePath)]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func getImage(){
        
    }
}
