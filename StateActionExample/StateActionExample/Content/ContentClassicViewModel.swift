//
//  ContentClassicViewModel.swift
//  StateActionExample
//
//  Created by Andrew Kuts on 2024-02-07.
//

import Combine

// MARK: Classic ViewModel
extension ContentView {

    class ClassicViewModel: ObservableObject {

        let imageName: String
        let buttonTitle: String
        @Published var viewState: ViewState
        @Published var text: String
        @Published var items: [String]

        // MARK: - Here is example how the small and comfortable ViewModel become bigger and bigger with each new feature.
        // MARK: - As a result, maintaining this ViewModel could be more difficult than it was intended for.

        /*

         @Published var isLoadable: Bool = false

         @Published var error: Error? = nil

         @Published var subInfo: String = ""

         @Published var bageNumber: Int? = nil

         ...
         */

        private let shim: Shim

        init(shim: Shim, viewState: ViewState, imageName: String, buttonTitle: String, text: String, items: [String]) {
            self.shim = shim
            self.viewState = viewState
            self.imageName = imageName
            self.buttonTitle = buttonTitle
            self.text = text
            self.items = items
        }

        func startViewModel() {
            if viewState != .initiation {
                viewState = .initiation
            }
        }

        func finishViewModel() {
            if viewState != .finished {
                viewState = .finished
            }
        }

        func buttonAction(parameter: String) {
            text = shim.addParameterToText(text: text, parameter: parameter)
        }

        /*

         func handLoadable() {
         }

         func handleError(_ error: Error) {
         }

         func handleSubInfo() {
         }

         func handleBage(number: Int) {
         }

         ...
         */
    }
}
