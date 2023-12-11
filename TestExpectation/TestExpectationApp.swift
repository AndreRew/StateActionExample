//
//  TestExpectationApp.swift
//  TestExpectation
//
//  Created by Andrew Kuts on 2023-12-06.
//

import SwiftUI

@main
struct TestExpectationApp: App {

    let viewModel = ContentView.ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
