//
//  APIClientMock.swift
//  TopDownDemo
//
//  Created by Bartosz Polaczyk on 18/02/2018.
//  Copyright © 2018 Bartosz Polaczyk. All rights reserved.
//

import Foundation

enum APIClientError: Error, Equatable{
    case missingCredentials
    case invalidPassword
    case networkError
}

class APIClientMock: APIClientable {
    
    func login(username: String, password: String, completionHandler: @escaping (Result<APIToken>) -> ()) {
        switch (username, password){
        case ("admin","admin"): completionHandler(.success("SECRET_TOKEN"))
        case ("",_), (_,""): completionHandler(.error(APIClientError.missingCredentials))
        default:
            // 50% chance for networkError
            if arc4random_uniform(2) == 0 {
                completionHandler(.error(APIClientError.invalidPassword))
            }else {
                completionHandler(.error(APIClientError.networkError))
            }
        }
    }
    

}
