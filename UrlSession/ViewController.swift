//
//  ViewController.swift
//  UrlSession
//
//  Created by Mangi on 25/02/20.
//  Copyright © 2020 Mangi. All rights reserved.
//

import UIKit
import TransitionButton

let BASE_URL = "https://balicuat.bajajallianz.com/OnlineCustomerPortal/ws/"
let LOGIN_SERVICANAME = "login/check_login"
let LOGIN_PARAMS = "{\"p_login_id\":\"%@\",\"p_login_flag\":\"%@\",\"p_password\":\"%@\",\"p_application\":\"%@\",\"p_version\":\"%@\"}"

let NEWSAPI = "https://newsapi.org/v2/everything?q=tesla&from=2021-03-14&sortBy=publishedAt&apiKey=583328c50b69489fa2e7ad221c57eac0"


class ViewController: UIViewController {
    
    var optional:String!
    
    let stringA = ""
    let stringB = String()
    
    let alertService = AlertService()
    
    @IBOutlet weak var submitBtn: TransitionButton!
    
    @IBOutlet weak var emailIdTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var customAlertBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitBtn.backgroundColor = .red
        submitBtn.setTitle("SUBMIT", for: .normal)
        submitBtn.cornerRadius = 10
        submitBtn.spinnerColor = .green
        
        let finalVal = findMissingNumberFromArray(num1: 16, num2: 2)
        print(finalVal)
        
        let withoutParamVal = witoutParameter()
        print(withoutParamVal)
        
        let tuples = (name:"Mangi",age:29,address:"Pune")
        let tuples1 = ("Mangi","29","Pune")
        print(tuples.address)
        print(tuples1.1)
        
        //Forced unwrapping
        optional = "Optional Value!"
        print(optional!)
        
        //Optional Binding
        if let tempOptional = optional {
            print("Optional Binding \(tempOptional)")
        }
        else{
            print("No Optional Binding")
        }
        
        //Nil coalescing ??
        let album = albumReleased(year:2014) ?? "unknown"
        print("The Album is \(album)")
        
        
        if stringA.isEmpty {
            print("StringA is empty")
        }
        else{
            print("StringA is not empty")
        }
        
        if stringB.isEmpty {
            print("StringB is empty")
        }
        else{
            print("StringB is not empty")
        }
        
        let num = largestAndSmallestNumber(array: [1, -5, 3, 90, 555, 20])
        print("Largest number is: \(num.large) and smallest number is: \(num.small)")
        
        //Enum calling
        shareImage(platform: .facebook)
        
        //Enum raw values
        print("Enum Raw value: \(EnumWithRawValues.twitter.rawValue)")
        
        //Enum with caseiterable
        print(EnumWithIterableValues.allCases.count)
        
        for platform in EnumWithIterableValues.allCases {
            print(platform.rawValue)
        }
        
        //Enum with associated values
        getFollowersOnSocialMedia(for: .twitter(followers: 15000))
    }
    
    //MARK:- Enum function using switch
    func shareImage(platform:SocialPlatform){
        switch platform {
        case .facebook:
            print("Facebook")
        case .twitter:
            print("Twitter")
        case .linkedIn:
            print("LinkedIn")
        case .instagram:
            print("Instagram")
        }
    }
    
    //MARK:- Enum function using Associated values
    func getFollowersOnSocialMedia(for platform:EnumWithAssociatedValues){
        switch platform {
        case .youtube(let subscriber) where subscriber > 10_000:
            print("Eligible for sponsored Video")
        case .twitter(let followers) where followers > 25_000:
            print("Eligible for sponsored Tweet")
        case .facebook, .instagram:
            print("Not eligible")
        case .twitter(followers: _):
            print("Twitter eligible")
        case .youtube(subscriber: _):
            print("Youtube eligible")
        }
    }
    
    func albumReleased(year: Int) -> String? {
        switch year {
        case 2006: return "Taylor Swift"
        case 2008: return "Fearless"
        case 2010: return "Speak Now"
        case 2012: return "Red"
        case 2014: return "1989"
        default: return nil
        }
    }
    
    //MARK:- Button Actions
    @IBAction func buttonAction(_ sender: UIButton) {
        do {
            try loginValidate()
        } catch LoginErrors.incompleteForm {
            Alert.showBasicAlert(title: "Incomplete Form", message: "Please fill out both email and password fields", vc: self)
        } catch LoginErrors.invalidEmail {
            Alert.showBasicAlert(title: "Invalid Email Format", message: "Please make sure you format your email correctly", vc: self)
        } catch LoginErrors.incorrectPasswordLength {
            Alert.showBasicAlert(title: "Password Too Short", message: "Password should be at least 8 characters", vc: self)
        } catch {
            Alert.showBasicAlert(title: "Unable To Login", message: "There was an error when attempting to login", vc: self)
        }
    }
    
    //MARK:- Custom Alert
    @IBAction func customAlertBtnAction(_ sender: Any) {
        let alertVC = alertService.alert(title: "Subscribe?", body: "Please subscribe to the channel if you found this helpful.", buttonTitle: "Confirm") {
            print("Confirm")
        } cancelCompletion: {
            print("Cancel")
        }

        
        present(alertVC, animated: true)
    }
    
    func loginValidate() throws {
        let email = emailIdTxtFld.text!
        let password = passwordTxtFld.text!
        
        if email.isEmpty || password.isEmpty {
            throw LoginErrors.incompleteForm
        }
        
        if !email.isValidEmail {
            throw LoginErrors.invalidEmail
        }
        
        if password.count < 8 {
            throw LoginErrors.incorrectPasswordLength
        }
        
        //All the fields are correct goto next screen
        Alert.showBasicAlert(title: "UrlSeesion", message: "Login Successfully!", vc: self)
    }
    
    
//NSString *loginParams = [NSString stringWithFormat:LOGIN_PARAMS, self.userIdTextField.text, USERID, self.passwordTextField.text, MOBILEAPP,[self getCurrentVersionFromApp]];
    @IBAction func getDataButton(_ sender: Any) {
//        let loginParams = String(format: LOGIN_PARAMS, "POONAMKATKE", "UID", "Test@1234", "IOS", "3.0.4")
//        self.sendPostParametersWithNSUrlSession(parameterString: loginParams, serviceName: LOGIN_SERVICANAME)
        
        let loginParams = String(format: LOGIN_PARAMS, "POONAMKATKE", "UID", "Test@1234", "IOS", "3.0.4")
        self.sendGetParametersWithNSUrlSession(parameterString: loginParams, serviceName: LOGIN_SERVICANAME)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        submitBtn.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.submitBtn.stopAnimation(animationStyle: .shake, completion: nil)
            })
        })
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
    
    func sendGetParametersWithNSUrlSession(parameterString : String, serviceName : String)-> Void {
        let urlStr = NEWSAPI
        let url = URL(string: urlStr)
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do {
                    let newsFeed = try decoder.decode(NewsFeed.self, from: data!)
                    
                    print(newsFeed)
                } catch  {
                    print("Error in JSON parsing")
                }
            }
        }
        dataTask.resume()
    }
    
    //MARK:- Other functions
    func findMissingNumberFromArray(num1:Int, num2:Int) -> Int {
        return num1 * num2
    }
    
    func witoutParameter() -> String {
        return "Test"
    }
    
    func largestAndSmallestNumber(array:[Int]) -> (large:Int, small:Int){
        var lar = array[0]
        var sma = array[0]
        for i in array[1..<array.count] {
            if i < sma {
                sma = i
            }
            else if i > lar {
                lar = i
            }
        }
        return (lar,sma)
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
 


