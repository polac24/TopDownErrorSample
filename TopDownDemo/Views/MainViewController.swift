//
//  MainViewController.swift
//  TopDownDemo
//
//  Created by Bartosz Polaczyk on 18/02/2018.
//  Copyright © 2018 Bartosz Polaczyk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private let token:APIToken
    private let errorHandler: ErrorHandleable
    
    @IBOutlet weak var label: UILabel!
    
    init(token: APIToken, errorHandler: ErrorHandleable){
        self.token = token
        self.errorHandler = errorHandler
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        label.text = token
    }
}
