//
//  ContentAction.swift
//  TestExpectation
//
//  Created by Andrew Kuts on 2023-12-06.
//

import Dufap

extension ContentView {

    // View Actions
    enum Action: ActionProtocol {
        case start
        case loading
        case finish
        case buttonAction(parameter: String)
        case openItem(String)
        case itemOpened(String)
        case selectNewPickerValue(String)
    }
}
