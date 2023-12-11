//
//  ContentViewModel.swift
//  TestExpectation
//
//  Created by Andrew Kuts on 2023-12-06.
//

import SwiftUI
import Dufap

extension ContentView {

    // The main purpose of the ViewModel is only two things:
    // Firstly is provide data for view and keep it updated.
    // Handle actions from the View
    class ViewModel: ViewModelProtocol {

        // State has to be @Published for updating UI
        @Published
        var state: State

        private let shim: Shim

        init(shim: Shim = .init(), state: State = .init()) {
            self.shim = shim
            self.state = state
        }

        func trigger(action: Action) {
            switch action {
            case .start:
                print("Start")
            case .finish:
                print("Finish")
            case .buttonAction(let parameter):
                print("Added parameter with first letter: \(shim.getFirstLetter(from: parameter) ?? "none")")
                state.text = shim.addParameterToText(text: state.text, parameter: parameter)
            }
        }
    }
}
