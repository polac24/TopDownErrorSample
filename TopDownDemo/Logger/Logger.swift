//
//  Logger.swift
//  TopDownDemo
//
//  Created by Bartosz Polaczyk on 18/02/2018.
//  Copyright © 2018 Bartosz Polaczyk. All rights reserved.
//

import UIKit

class Logger:Loggerable{
    func log(message: String) {
        print(message)
    }
    
    func log(debug error: Error) {
        // guard debug mode
        
        print("DEBUG: Error recieved: \(error)")
    }
    
}
