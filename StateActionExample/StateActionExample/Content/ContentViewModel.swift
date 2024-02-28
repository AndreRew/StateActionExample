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
        // MARK: It will always be updated on the Main
        @Published
        var state: State

        private let shim: ShimContentView

        // MARK: - Init will not become a mess with hundreds parameters
        init(shim: ShimContentView = Shim(), state: State = .init()) {
            self.shim = shim
            self.state = state
        }

        // MARK: This function handle handle all events from View.
        // MARK: As a benefit of this approach we will get only one directional entry point (API) from a View.
        // MARK: Easy extended with new action by adding a new case. 
        // MARK: After adding the compiler, it will help to identify all the places where it might have an impact.
        func trigger(action: Action) {

            // MARK: It is possible to handle multiple logging or custom handling methods with ease.
            shim.baseHandling(action: action)

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

            case .openItem(let item):
                // TODO: Add preload item
                state.viewState = .openItem(item)

            case .selectNewPickerValue(let newPickerValue):

                // MARK: Full control over binding and Updating UI
                // MARK: If you want to lock action until action is done it's easily can be.
                if state.isSelectingPickerFinished {
                    state.isSelectingPickerFinished = false

                    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
                        guard let self else { return }
                        state.pickerSelected = newPickerValue
                        state.isSelectingPickerFinished = true
                    }
                } else {
                    print(newPickerValue)
                }

            case .itemOpened:
                break
            }
        }
    }
}

private extension ContentView.ViewModel {

    func finishAction() {
        // MARK: Easy handle concurrency.

        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self else { return }

            if state.viewState != .finished {

                shim.doFinishAction()
                state.viewState = .finished
            } else {

                // Handling navigation if needed
                shim.handleRoute(ContentRoute())
            }
        }
    }

    func loadingAction() {

        // MARK: Another way of handle concurrency.

        Task { [weak self] in
            guard let self else { return }

            if state.viewState != .loaded {
                let newItems = await shim.doLoadAction()
                state.items = newItems
                state.viewState = .loaded
            }
        }
    }

    func buttonAction(parameter: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            state.text = shim.addParameterToText(text: state.text, parameter: parameter)
        }
    }
}
