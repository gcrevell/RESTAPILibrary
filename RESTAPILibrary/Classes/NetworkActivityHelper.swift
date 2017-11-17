//
//  NetworkActivityHelper.swift
//  Pods-RESTAPILibrary_Tests
//
//  Created by Gabriel Revells on 11/17/17.
//

import UIKit

internal class NetworkActivityHelper {

    // This is a static-only class. No instances should be created. Ever
    @available(*, unavailable) fileprivate init() {}

    static internal private(set) var activityIndicatorCount = 0

    static internal func showNetworkActivity() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            NetworkActivityHelper.activityIndicatorCount += 1
        }
    }

    static internal func hideNetworkActivity() {
        DispatchQueue.main.async {
            NetworkActivityHelper.activityIndicatorCount -= 1

            if NetworkActivityHelper.activityIndicatorCount <= 0 {
                // If, somehow, we got to a negative count, reset to 0
                NetworkActivityHelper.activityIndicatorCount = 0
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }

    /**
     A reset method to force clearing the network activity indicator. **This
     should never be called.** It is for unit testing only.
    */
    static internal func reset() {
        NetworkActivityHelper.activityIndicatorCount = 0
    }

}
