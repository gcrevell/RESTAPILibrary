//
//  NetworkActivityHelperTests.swift
//  RESTAPILibrary_Tests
//
//  Created by Gabriel Revells on 11/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
@testable import RESTAPILibrary

class NetworkActivityHelperTests: XCTestCase {

    override func setUp() {
        NetworkActivityHelper.reset()
    }

    func testNAIHidden() {
        checkActivityIndicator(is: 0)
    }

    func testNAIShowsOnSingleCall() {
        NetworkActivityHelper.showNetworkActivity()

        checkActivityIndicator(is: 1)
    }

    func testNAIShowsOnTwoCalls() {
        NetworkActivityHelper.showNetworkActivity()
        NetworkActivityHelper.showNetworkActivity()

        checkActivityIndicator(is: 2)
    }

    func testNAIValueAfterOneHide() {
        NetworkActivityHelper.showNetworkActivity()
        NetworkActivityHelper.showNetworkActivity()
        NetworkActivityHelper.hideNetworkActivity()

        checkActivityIndicator(is: 1)
    }

    func testNAIValueAfterTwoHides() {
        NetworkActivityHelper.showNetworkActivity()
        NetworkActivityHelper.showNetworkActivity()
        NetworkActivityHelper.hideNetworkActivity()
        NetworkActivityHelper.hideNetworkActivity()

        checkActivityIndicator(is: 0)
    }

    /**
     Helper function to check asynchonously if the network activity count is at
     the correct value.
     */
    private func checkActivityIndicator(is value: Int) {
        // This test must be run async with a delay, because the varaible that
        // is tested, the activity indicator count, is set asynchronously

        let expectation = self.expectation(description: "Async dispatch time")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            XCTAssertEqual(NetworkActivityHelper.activityIndicatorCount, value)
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 2)
    }

}
