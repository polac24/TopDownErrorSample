//
//  Loggerable.swift
//  TopDownDemo
//
//  Created by Bartosz Polaczyk on 18/02/2018.
//  Copyright © 2018 Bartosz Polaczyk. All rights reserved.
//

import UIKit

protocol Loggerable{
    func log(message: String)
    func log(debug: Error)
}
