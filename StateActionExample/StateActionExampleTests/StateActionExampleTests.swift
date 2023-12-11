//
//  StateActionExampleTests.swift
//  StateActionExampleTests
//
//  Created by Andrew Kuts on 2023-12-11.
//

import XCTest
@testable import StateActionExample

final class StateActionExampleTests: XCTestCase {

    func testContentViewModel() {

        let shim = ContentView.Shim()
        let viewModel = ContentView.ViewModel(shim: shim)

        let parameter = "test"
        let expectedText = shim.addParameterToText(text: viewModel.state.text, parameter: parameter)

        viewModel.trigger(action: .buttonAction(parameter: parameter))
        XCTAssertEqual(viewModel.state.text, expectedText)
    }

    func testExampleForAnalytics() {

        let shim = ShimWithAnalytics()
        let viewModel = ContentView.ViewModel(shim: shim)

        let parameter = "test"
        let expectedText = shim.addParameterToText(text: viewModel.state.text, parameter: parameter)

        viewModel.trigger(action: .buttonAction(parameter: parameter))
        XCTAssertEqual(shim.analyticsHistory.first, "ANALYTICS: addParameterToText(text:parameter:) handle text: Hello, world! and returned result: Hello, world! test")
    }

}
