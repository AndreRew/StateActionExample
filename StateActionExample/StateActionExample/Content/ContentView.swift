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

            switch viewModel.viewState {

            case .initiation:
                Text("Loading")
                    .onAppear { viewModel.trigger(action: .loading) }

            case .loading, .loaded:
                mainFlowView

            case .finished:
                Text("Finished")

            case .error:
                Text("Error")

            case .openItem(let item):
                // MARK: We can add custom animation for this thing
                Text(item)
            }
        }
        .padding()
        .onDisappear { viewModel.trigger(action: .finish) }
    }

    private var mainFlowView: some View {

        VStack {

            Image(systemName: viewModel.imageName)
                .imageScale(.large)
                .foregroundColor(.accentColor)

            Text(viewModel.text)

            Picker("Picker", selection: .init(get: { viewModel.pickerSelected }, set: { viewModel.trigger(action: .selectNewPickerValue($0)) })) {
                ForEach(viewModel.pickerValues, id: \.self) { item in
                    Text(item)
                        .tag(item)
                }
            }
            .pickerStyle(.segmented)

            if !viewModel.items.isEmpty {
                NavigationView {
                    List(viewModel.items, id: \.self) { item in
                        NavigationLink("GO -> \(item)") {
                            Text(item)
                                .onAppear { viewModel.trigger(action: .itemOpened(item)) }
                        }
                    }
                }
            }

            Button("Test Action", action: { viewModel.trigger(action: .buttonAction(parameter: "Testing actions")) })
                .padding()
        }
        .navigationTitle("Test")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
