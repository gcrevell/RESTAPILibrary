//
//  URLSessionExtension.swift
//  Pods-RESTAPILibrary_Tests
//
//  Created by Gabriel Revells on 11/17/17.
//

import UIKit

public extension URLSession {

    /**
     Basic wrapper around submitting a network request.

     When performing a network request, theres some basic tasks we must always
     perform. To simplify them, this wrapper method takes care of it. It gets
     the global shared session, creates the data task, shows and hides the
     network indicator, and starts the task.

     - Parameters:
       - request:       The URL request to make. Should be a properly formed
                            URLRequest
       - completion:    The callback function to run when the request completes
                            successfully
    */
    public static func submit(_ request:    URLRequest,
                              completion:   @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            NetworkActivityHelper.hideNetworkActivity()
            completion(data, response, error)
        }

        NetworkActivityHelper.showNetworkActivity()
        dataTask.resume()
    }

}
