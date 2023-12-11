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

        let imageName: String
        let buttonTitle: String

        var text: String

        init(imageName: String = "globe", buttonTitle: String = "Testing actions", text: String = "Hello, world!") {
            self.imageName = imageName
            self.buttonTitle = buttonTitle
            self.text = text
        }
    }

    enum State2: StateProtocol {
        case firstCase
        case secondCase
    }
}
