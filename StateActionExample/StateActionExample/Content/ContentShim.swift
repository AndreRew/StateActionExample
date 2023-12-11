//
//  ContentShim.swift
//  TestExpectation
//
//  Created by Andrew Kuts on 2023-12-06.
//

extension ContentView {

    // Dependences
    class Shim {

        // If we don't know how it should works we can define it as another dependency and set in init
        let addParameterToText: (String, String) -> String

        init(addParameterToText: @escaping (String, String) -> String = { _, _ in "" }) {
            self.addParameterToText = addParameterToText
        }

        // If we know how it should works we can implement it as a function
        func addParameterToText(text: String, parameter: String) -> String {
            return "\(text) \(parameter)"
        }

        func getFirstLetter(from text: String) -> String? {

            guard let firstLetter = text.first else {
                return nil
            }

            return "\(firstLetter)"
        }
    }
}

class ShimWithAnalytics: ContentView.Shim {

    var analyticsHistory: [String] = []

    override func getFirstLetter(from text: String) -> String? {
        let firstLetter = super.getFirstLetter(from: text)
        defer {
            let analyticsEvent = "ANALYTICS: \(#function) handle text: \(text) and returned first letter: \(firstLetter ?? "NONE")"
            analyticsHistory.append(analyticsEvent)
        }

        return firstLetter
    }

    override func addParameterToText(text: String, parameter: String) -> String {
        let resultText = super.addParameterToText(text: text, parameter: parameter)
        defer {
            let analyticsEvent = "ANALYTICS: \(#function) handle text: \(text) and returned result: \(resultText)"
            analyticsHistory.append(analyticsEvent)
        }

        return resultText
    }
}
