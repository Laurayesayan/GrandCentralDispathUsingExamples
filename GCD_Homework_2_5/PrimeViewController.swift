//
//  PrimeViewController.swift
//  GCD_Homework_2_5
//
//  Created by Лаура Есаян on 15.03.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

class PrimeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func findPrimeNumbers(_ sender: Any) {
        let enteredNumber = Int(self.textField.text!)!
        DispatchQueue.global().async { [weak self] in
            for number in 2...enteredNumber {
                var time = CFAbsoluteTimeGetCurrent()
                if self!.isPrime(number, time: &time) {
                    print("Prime number:", number, "Time:", time)
                }
            }
        }

    }
    
    func isPrime(_ number: Int, time: inout CFAbsoluteTime) -> Bool {
        for i in 2..<number {
            if number % i == 0 {
                return false
            }
        }

        time = CFAbsoluteTimeGetCurrent() - time
        
        return true
    }
    
}
