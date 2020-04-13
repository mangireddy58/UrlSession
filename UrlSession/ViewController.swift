//
//  ViewController.swift
//  UrlSession
//
//  Created by Mangi on 25/02/20.
//  Copyright © 2020 Mangi. All rights reserved.
//

import UIKit

let BASE_URL = "https://balicuat.bajajallianz.com/OnlineCustomerPortal/ws/"
let LOGIN_SERVICANAME = "login/check_login"
let LOGIN_PARAMS = "{\"p_login_id\":\"%@\",\"p_login_flag\":\"%@\",\"p_password\":\"%@\",\"p_application\":\"%@\",\"p_version\":\"%@\"}"


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//NSString *loginParams = [NSString stringWithFormat:LOGIN_PARAMS, self.userIdTextField.text, USERID, self.passwordTextField.text, MOBILEAPP,[self getCurrentVersionFromApp]];
    @IBAction func getDataButton(_ sender: Any) {
        let loginParams = String(format: LOGIN_PARAMS, "RAJKAMALPAL", "UID", "test@1234", "IOS", "3.0.4")
        self.sendPostParametersWithNSUrlSession(parameterString: loginParams, serviceName: LOGIN_SERVICANAME)
    }
    
    //MARK:- Normal Json Parsing
    func sendPostParametersWithNSUrlSession(parameterString : String, serviceName : String)-> Void {
        let urlStr = "\(BASE_URL)\(serviceName)"
        let jsonString = String(format: "%@", parameterString)
        let jsonData = jsonString.data(using:.utf8)
        var request = URLRequest(url: URL(string: urlStr)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("https://balicuat.bajajallianz.com", forHTTPHeaderField: "Origin")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(30)
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {(data , response, error) in
            if(error != nil){
                print("Error \(String(describing: error))")
            }
            else {
                do {
                    let fetchedDataDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    print(fetchedDataDictionary!)
                }
                catch let error as NSError {
                    print(error.debugDescription)
                }
            }
        }
        task.resume()
    }
}
/*
 NSString *pasaParams = [NSString stringWithFormat:PASA_ELIGIBILTY_PARAMS, self.objUserDataModel.policyId, self.customerIdStr];
 NSString *serviceUrl = [NSString stringWithFormat:@"%@", PASA_ELIGIBILITY_SERVICENAME];
 NSData *data = [pasaParams dataUsingEncoding:NSUTF8StringEncoding];
 NSError *error;
 NSDictionary *parametersDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
 DebugLog(@"Service URL: %@", serviceUrl);
 DebugLog(@"Service Parameters: %@", pasaParams);
 DebugLog(@"Service Parameters Dictionalry: %@", parametersDictionary);
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serviceUrl]];
 [request setHTTPMethod:@"POST"];
 [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
 [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
 [request setTimeoutInterval:60];
 [request setHTTPBody:data];
 
 NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:nil];
 [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
     
     NSError *jsonError;
     NSData *objectData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
     NSDictionary *jsonDataDict = [NSJSONSerialization JSONObjectWithData:objectData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&jsonError];
     DebugLog(@"got Userdata Response: %@", jsonDataDict);
     if(jsonDataDict != nil) {
     }
     else {
         [self hideProgressIndicator];
     }
 }] resume];
 */
 

