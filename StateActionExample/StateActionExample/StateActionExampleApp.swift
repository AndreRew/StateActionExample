//
//  StateActionExampleApp.swift
//  StateActionExample
//
//  Created by Andrew Kuts on 2023-12-11.
//

import SwiftUI

@main
struct StateActionExampleApp: App {
    let viewModel = ContentView.ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
