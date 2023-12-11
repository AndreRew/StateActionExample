//
//  ContentView.swift
//  TestExpectation
//
//  Created by Andrew Kuts on 2023-12-06.
//

import SwiftUI
import Dufap

struct ContentView: View {

    // View model contains only State and Action handler
    // View State contains all data for view.
    // All Actions from view described in Action
    @ObservedObject
    var viewModel: AnyViewModel<State, Action>

    init(viewModel: ViewModel = ViewModel()) {
        self.viewModel = AnyViewModel(viewModel)
    }

    var body: some View {
        VStack {
            Image(systemName: viewModel.imageName)
                .imageScale(.large)
                .foregroundColor(.accentColor)

            Text(viewModel.text)

            Button("Test Action", action: { viewModel.trigger(action: .buttonAction(parameter: "Testing actions")) })
                .padding()
        }
        .padding()
        .onAppear { viewModel.trigger(action: .start) }
        .onDisappear { viewModel.trigger(action: .finish) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
