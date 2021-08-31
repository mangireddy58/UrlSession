//
//  TimerController.swift
//  UrlSession
//
//  Created by Mangi on 30/07/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import UIKit

class TimerController: UIViewController {

    var timer: Timer?
    var reverseTimer: Timer?
    var totalSeconds: Int = 0
    
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var reverseBtn: UIButton!
    @IBOutlet weak var reverseLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startBtn.tag = 1
        reverseBtn.tag = 2
    }
    
    //MARK:- OTP timer func
    func startOtpTimer() {
        totalSeconds = 1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDownTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountDownTime() {
        self.populateLabelwithTime(seconds: totalSeconds)
        if totalSeconds != 0 {
            totalSeconds += 1
        }else{
            timer?.invalidate()
            self.timerLbl.text = "0"
        }
    }
    
    @objc func populateLabelwithTime(seconds: Int){
        timerLbl.text = String(seconds)
    }
    
    //MARK:- Reverse Timer
    func reverseOtpTimer() {
        totalSeconds = 120
        reverseTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(reverseCountDownTime), userInfo: nil, repeats: true)
    }
    
    @objc func reverseCountDownTime() {
        self.populateReverseLabelwithTime(seconds: totalSeconds)
        if totalSeconds != 0 {
            totalSeconds -= 1
        }else{
            reverseTimer?.invalidate()
            self.reverseLbl.text = "0"
        }
    }
    
    @objc func populateReverseLabelwithTime(seconds: Int){
        reverseLbl.text = String(seconds)
    }
        
    @IBAction func fnForButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            reverseTimer?.invalidate()
            self.startOtpTimer()
            break
        case 2:
            timer?.invalidate()
            self.reverseOtpTimer()
            break
        default:
            break
        }
    }
    
}
