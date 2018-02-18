//
//  FlowCoordinator.swift
//  TopDownDemo
//
//  Created by Bartosz Polaczyk on 18/02/2018.
//  Copyright © 2018 Bartosz Polaczyk. All rights reserved.
//

import UIKit

class FlowCoordinator {
    
    private let parentErrorHandler:ErrorHandleable
    private let apiClient:APIClientable
    private let reachability:Reachable
    
    private let navigation:UINavigationController = {
        let nav = UINavigationController()
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    private var errorHandler:ErrorHandleable {
        return parentErrorHandler.catch(APIClientError.invalidPassword, action: {[weak self] _ in
            self?.present(title: "Wrong password", message: "Use admin/admin credentials to login")
        }).catch(APIClientError.networkError, action: {[weak self] error in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.reachability.isConnectedToTheInternet {
                // some problem on a backend side, follow with standard error presentation
                throw error
            }
            strongSelf.present(title: "No Internet", message: "You don't have access to the Internet. Please try again later.")
        }).catch(APIClientError.self) { [weak self] (error) in
            self?.present(apiError: error)
        }
    }
    
    init(window: UIWindow, apiClient:APIClientable, reachability: Reachable, errorHandler:ErrorHandleable){
        self.apiClient = apiClient
        self.parentErrorHandler = errorHandler
        self.reachability = reachability
        
        window.rootViewController = navigation
    }
    
    func start(){
        let loginVC = buildLogin() { [weak self] token in
            self?.goToMain(token:token)
        }
        navigation.pushViewController(loginVC, animated: false)
    }
    
    private func goToMain(token: APIToken){
        let mainVC = buildMain(token)
        navigation.pushViewController(mainVC, animated: true)
    }
    
    private func buildLogin(result: @escaping (APIToken) -> Void) -> UIViewController{
        return LoginViewController(apiClient: apiClient, errorHandler: errorHandler, resultAction: result)
    }
    
    private func buildMain(_ token:APIToken) -> UIViewController{
        return MainViewController(token: token, errorHandler: errorHandler)
    }
    
    private func present(apiError: APIClientError){
        let alert = UIAlertController(title: "API Error", message:  "Response from a server: \(apiError)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        navigation.present(alert, animated: true, completion: nil)
    }
    
    private func present(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        navigation.present(alert, animated: true, completion: nil)
    }
}
