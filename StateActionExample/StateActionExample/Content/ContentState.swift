//
//  ContentState.swift
//  TestExpectation
//
//  Created by Andrew Kuts on 2023-12-06.
//

import Dufap

extension ContentView {

    // All View's state
    struct State: StateProtocol {

        /*
         var isLoadable: Bool = false
         var error: Error? = nil
         var subInfo: String = ""
         var bageNumber: Int? = nil
         ...
         */

        let imageName: String
        let buttonTitle: String
        var items: [String]
        var text: String
        var viewState: ViewState
        var isSelectingPickerFinished: Bool = true
        var pickerSelected: String = "First"
        var pickerValues: [String] = ["First", "Second"]

        init(imageName: String = "globe", buttonTitle: String = "Testing actions", items: [String] = [], text: String = "Hello, world!", viewState: ViewState = .initiation) {
            self.imageName = imageName
            self.buttonTitle = buttonTitle
            self.items = items
            self.text = text
            self.viewState = viewState
        }
    }

    enum ViewState: Equatable {
        case initiation
        case loading
        case loaded
        case finished
        case error
        case openItem(String)
    }
}
