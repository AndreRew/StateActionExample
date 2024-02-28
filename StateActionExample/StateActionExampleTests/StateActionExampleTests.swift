//
//  StateActionExampleTests.swift
//  StateActionExampleTests
//
//  Created by Andrew Kuts on 2023-12-11.
//

import XCTest
@testable import StateActionExample

extension ContentView.Action: CaseIterable {
    public static var allCases: [StateActionExample.ContentView.Action] {
        [
            .loading,
            .buttonAction(parameter: "Test parameter"),
            .finish,
            .start,
            .openItem("ID"),
            .itemOpened("ID"),
            .selectNewPickerValue("First"),
        ]
    }
}

final class StateActionExampleTests: XCTestCase {

    private lazy var analytics = Analytics.sharedInstance

    // MARK: It is an example how any service could be testable for ViewModel.
    // MARK: Another dependency could be faked if they don't needed.
    private lazy var shim = ContentView.Shim(analytics: analytics)
    private lazy var viewModel = ContentView.ViewModel(shim: shim)

    func testContentViewModel() {

        for action in ContentView.Action.allCases {

            viewModel.trigger(action: action)

            switch action {

            case .start, .finish, .openItem, .itemOpened, .selectNewPickerValue:
                // TODO: Add tests
                print("ACTION: \(action) DO NOT HAVE A TEST")

            case .loading:
                XCTAssertFalse(analytics.loggedActions.isEmpty)

            case .buttonAction(let parameter):
                let expectedText = shim.addParameterToText(text: viewModel.state.text, parameter: parameter)
                viewModel.trigger(action: .buttonAction(parameter: parameter))
                XCTAssertEqual(viewModel.state.text, expectedText)
            }
        }
    }

    func testForTestPlan() {
        print("ForTestPlan")
    }
}
