//
//  ContentClassicViewModel.swift
//  StateActionExample
//
//  Created by Andrew Kuts on 2024-02-07.
//

import Combine
import Foundation

// MARK: Classic ViewModel
extension ContentView {

    class ClassicViewModel: ObservableObject {

        let imageName: String
        let buttonTitle: String
        @Published var viewState: ViewState
        @Published var text: String
        @Published var items: [String]

        var cancellable: AnyCancellable? = nil
        // MARK: - Here is example how the small and comfortable ViewModel become bigger and bigger with each new feature.
        // MARK: - As a result, maintaining this ViewModel could be more difficult than it was intended for.

        /*

         @Published var isLoadable: Bool = false

         @Published var error: Error? = nil

         @Published var subInfo: String = ""

         @Published var bageNumber: Int? = nil

         ...
         */

        private let shim: ShimContentView

        init(shim: ShimContentView = Shim(), viewState: ViewState, imageName: String, buttonTitle: String, text: String, items: [String]) {
            self.shim = shim
            self.viewState = viewState
            self.imageName = imageName
            self.buttonTitle = buttonTitle
            self.text = text
            self.items = items
        }

        func start() {

            if viewState != .initiation {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    viewState = .initiation
                }
            }

            cancellable = $text
                .receive(on: DispatchQueue.main)
                .removeDuplicates()
                .sink(receiveValue: { print($0) })
        }

        func finish() {

            if viewState != .finished {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    viewState = .finished
                }
            }
        }

        func buttonAction(parameter: String) {
            // MARK: We need to be sure that UI will be updated on the Main.
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                text = shim.addParameterToText(text: text, parameter: parameter)
            }
        }

        func loading() {

            Task { [weak self] in
                guard let self else { return }

                let newItems = await shim.doLoadAction()

                // MARK: Need to jump to the Main thread for updating UI.
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    // It's to be on Main only
                    items = newItems
                }
            }
        }

        func openItem(id: String) {
            // MARK: We need to be sure that UI will be updated on the Main.
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                viewState = .openItem(id)
            }
        }

        func itemOpened(id: String) {
            // ...
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
