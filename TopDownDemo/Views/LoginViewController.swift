//
//  LoginViewController.swift
//  TopDownDemo
//
//  Created by Bartosz Polaczyk on 18/02/2018.
//  Copyright © 2018 Bartosz Polaczyk. All rights reserved.
//

import UIKit

enum LoginViewControllerError: Error{
    case invalidState
}

class LoginViewController: UIViewController {

    private let errorHandler:ErrorHandleable
    private let apiClient:APIClientable
    private let resultAction:(APIToken) -> Void
    
    @IBOutlet weak var loginTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    init(apiClient:APIClientable, errorHandler:ErrorHandleable, resultAction: @escaping (APIToken) -> Void){
        self.errorHandler = errorHandler
        self.apiClient = apiClient
        self.resultAction = resultAction
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let login = loginTextfield.text,
            let password = passwordTextField.text else {
                errorHandler.throw(LoginViewControllerError.invalidState)
                return
        }
        
        apiClient.login(username: login, password: password) {[weak self] (result) in
            switch result {
            case .success(let token):
                self?.resultAction(token)
            case .error(let error):
                self?.errorHandler.throw(error)
            }
        }
    }
}
