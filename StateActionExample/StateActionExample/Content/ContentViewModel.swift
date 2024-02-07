//
//  ContentViewModel.swift
//  TestExpectation
//
//  Created by Andrew Kuts on 2023-12-06.
//

import SwiftUI
import Dufap

extension ContentView {

    // MARK: The main purpose of the ViewModel is only two things:
    // MARK: Firstly is provide data for view and keep it updated. The `@Published var state: State` is responsible for it.
    // MARK: Handle actions from the View
    class ViewModel: ViewModelProtocol {

        // MARK: State has to be @Published for updating UI
        // MARK: Everything that could or should be on View is stored here.
        // MARK: It is provide only one way, directional data flow.
        @Published
        var state: State

        private let shim: Shim

        // MARK: - Init will not become a mess with hundreds parameters
        init(shim: Shim = .init(), state: State = .init()) {
            self.shim = shim
            self.state = state
        }

        // This function handle handle all events from View.
        // As a benefit of this approach we will get only one directional entry point (API) from a View.
        // Easy extended with new action by adding a new case.
        func trigger(action: Action) {

            // Easy handle logging all action in one place if needed
            shim.logAnalytics(action)

            switch action {
            case .start:
                if state.viewState != .initiation {
                    state.viewState = .initiation
                }

            case .finish:
                finishAction()

            case .loading:
                loadingAction()

            case .buttonAction(let parameter):
                buttonAction(parameter: parameter)
            }
        }
    }
}

private extension ContentView.ViewModel {

    func finishAction() {
        // MARK: Easy handle concurrency.

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self else { return }

            if state.viewState != .finished {
                state.viewState = .finished
            }
        }
    }

    func loadingAction() {

        // MARK: Easy handle concurrency.
        if state.viewState != .loaded {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                guard let self else { return }
                state.viewState = .loaded
            }
        }
    }

    func buttonAction(parameter: String) {
        // Easy handle custom logging
        print("Added parameter with first letter: \(shim.getFirstLetter(from: parameter) ?? "none")")
        state.text = shim.addParameterToText(text: state.text, parameter: parameter)
    }
}
