//
//  StateActionExampleApp.swift
//  StateActionExample
//
//  Created by Andrew Kuts on 2023-12-11.
//

import SwiftUI

@main
struct StateActionExampleApp: App {

    // Keep flow actual easier to store ViewModel outside of View.
    let viewModel = ContentView.ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
