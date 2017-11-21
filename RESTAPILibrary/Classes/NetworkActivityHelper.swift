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

    /**
     The count of times the network indicator should be shown.

     This getter is internal, but only for testing purposes.
    */
    static internal private(set) var activityIndicatorCount = 0

    /**
     Show the netowrk activity indicator, if it is not already showing

     This static function allows code to show the activity indicator for
     the network. It also contains an internal count that will be incremented
     to track the number of calls to show this.

     This method is thread-safe and can be called from any thread.

     - SeeAlso:
     `hideNetworkActivity()`
    */
    static internal func showNetworkActivity() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            NetworkActivityHelper.activityIndicatorCount += 1
        }
    }

    /**
     Hides the system network activity indicator, if the number of hides equals
     the number of shows.

     This function should be called when a network access has finished. It will
     decrement the count of current requests to show the system network
     indicator. If there are no more requests, the indicator is hidden and if
     the value has become negative, then it is reset to 0.

     This method is thread-safe and can be called from any thread.

     - SeeAlso:
     `showNetworkActivity()`
    */
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
