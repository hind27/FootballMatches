//
//  Session .swift
//  FootBallApp
//
//  Created by hind on 2/20/19.
//  Copyright © 2019 hind. All rights reserved.
//

import Foundation


//MARK: APIUrlData
struct APIUrlData {
    let scheme: String
    let host: String
    let path: String
}

class Session {
    
    //MARK: Properties
    
    private let session: URLSession!
    private let apiUrlData: APIUrlData
    
    //MARK: Initializer
    
    init(apiData: APIUrlData) {
        
        // Get your Configuration Object
        let sessionConfiguration = URLSessionConfiguration.default
        
        // Set the Configuration on your session object
        session = URLSession(configuration: sessionConfiguration)
        apiUrlData = apiData
    }
    
    //MARK: Data Task Request
    
    func makeRequest(Url: URL, responseClosure: @escaping (NSData?, String?) -> Void){
        
         //request.setValue("secret-keyValue", forHTTPHeaderField: "secret-key")
        // Create request from passed URL
        var request = URLRequest(url: Url)
        request.httpMethod = "GET"
        // Mandatory Headers
        let finalHeaders = [Constants.APIHeaderKeys.accept: Constants.APIHeaderValues.application_json,
                            Constants.APIHeaderKeys.contentType: Constants.APIHeaderValues.application_json,
                            Constants.APIHeaderKeys.X_Auth_Token: Constants.APIHeaderValues.X_Auth_Token ] as [String:String]
     
        // Add headers if present
        if let requestHeaders:[String : String] = finalHeaders  {
            for (key, value) in requestHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
    
        // Create Task
        let task = session.dataTask(with: request) {(data, response, error) in
            
            // Check for errors
            if let error = error {
                responseClosure(nil, error.localizedDescription)
                return
            }
            
            // Check for successful response via status codes
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode < 200 && statusCode > 299 {
                print("status code returned other than 2xx")
                responseClosure(nil,"Unsuccessful Status Code Received")
            }
            
            responseClosure(data! as NSData, nil);
        }
        
        task.resume()
    }
    
    //MARK: Build URL for request
    
    func urlForRequest(apiMethod: String?, pathExtension: String? = nil, pathExtensionplas: String? = nil, parameters: [String : AnyObject]? = nil) -> URL {
        var components = URLComponents()
        components.scheme = apiUrlData.scheme
        components.host = apiUrlData.host // ./.
        components.path = apiUrlData.path + (apiMethod ?? "") + (pathExtension ?? "") + (pathExtensionplas ?? "")
        
        
        if let parameters = parameters {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems?.append(queryItem)
            }
        }
        return components.url!
    }
}
