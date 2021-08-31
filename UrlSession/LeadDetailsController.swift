//
//  LeadDetailsController.swift
//  UrlSession
//
//  Created by Mangi on 22/02/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

let LEAD_URL = "https://balicuat.bajajallianz.com/INSTAB_uat5/ws/ldserviece/getLeadDtlsList"
let LEAD_PARAMETERS = "{\"p_emp_code\":\"250649\"}"


class LeadDetailsController: UIViewController {

    @IBOutlet weak var leadTblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var leadArr = [NSDictionary]()
    var filterArr = [NSDictionary]()
    var isFilterData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self;
        self.getLeadDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.leadTblView.estimatedRowHeight = 245
        self.leadTblView.rowHeight = UITableView.automaticDimension
    }
    
    func getLeadDetails() {
        let urlStr = LEAD_URL
        let jsonStr = String(format: "%@", LEAD_PARAMETERS)
        let jsonData = jsonStr.data(using: .utf8)
        var request = URLRequest(url: URL(string: urlStr)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(30)
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){ (data,response,error) in
            if error != nil {
                print("Error \(String(describing: error))")
            }
            else{
                do {
                    let responseDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    self.leadArr = responseDict!["p_lead_dtls_list"] as! [NSDictionary]
                    print("Data:\(self.leadArr)")
                    self.leadTblView.dataSource = self
                    self.leadTblView.delegate = self
                    self.leadTblView.reloadData()
                } catch let error as NSError {
                    print(error.debugDescription)
                }
            }
        }
        task.resume()
    }
}

extension LeadDetailsController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterData {
            return self.filterArr.count
        }
        else{
            return self.leadArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if isFilterData {
            let tempDict = filterArr[indexPath.row]
            cell.textLabel?.text = tempDict["stringval2"] as? String
            cell.detailTextLabel?.text = tempDict["stringval1"] as? String
        }
        else{
            let tempDict = self.leadArr[indexPath.row]
            cell.textLabel?.text = tempDict["stringval2"] as? String
            cell.detailTextLabel?.text = tempDict["stringval1"] as? String
        }
        return cell
    }
    
}

extension LeadDetailsController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isFilterData = false
            self.leadTblView.reloadData()
        }
        else{
            isFilterData = true
            self.filterArr = [NSDictionary]()
            for dataDict in self.leadArr {
                let data = dataDict["stringval2"] as! String
                if (data.range(of: searchText, options: .caseInsensitive) != nil) {
                    self.filterArr.append(dataDict)
                }
            }
            self.leadTblView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
