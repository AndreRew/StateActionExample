//
//  ContentShim.swift
//  TestExpectation
//
//  Created by Andrew Kuts on 2023-12-06.
//

// MARK: - Shim
extension ContentView {

    class Shim {

        // MARK: Dependences
        let addParameterToText: (String, String) -> String
        let logAnalytics: (Action) -> Void

        // MARK: To avoid code duplication, we can pass all reusable systems as a dependency.
        init(
            addParameterToText: @escaping (String, String) -> String = { _, _ in "" },
            logAnalytics: @escaping (Action) -> Void = Analytics.sharedInstance.handelContentViewAction(_:)
        ) {
            self.addParameterToText = addParameterToText
            self.logAnalytics = logAnalytics
        }

        // MARK: Inside of Shim could be function with uniq logic relevant only to this ContentView.
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

// MARK: Example of Custom Shim with Analytics
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

struct Analytics {

    static let sharedInstance = Analytics()

    private init() { }

    func handelContentViewAction(_ action: ContentView.Action) {

        switch action {
        case .start, .loading, .finish:
            print("ANALYTICS: this action '\(action)' do not needed to be logged")

        case .buttonAction(let parameter):
            print("ANALYTICS: log button action with value \(parameter)")
        }
    }
}
