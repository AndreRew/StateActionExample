//
//  ContentShim.swift
//  TestExpectation
//
//  Created by Andrew Kuts on 2023-12-06.
//

import Foundation

// MARK: - Shim
protocol ShimContentView {

    // MARK: It could be improved. We can confirm Shim protocol to the `ActionProvider` from Dufap lib
    func doFinishAction()
    func doLoadAction() async -> [String]
    func addParameterToText(text: String, parameter: String) -> String
    func getFirstLetter(from text: String) -> String?
    func baseHandling(action: ContentView.Action)
    func handleRoute(_ route: ContentRoute)

}

extension ContentView {

    // MARK: My understanding of Shims may not be correct so please bear with me.
    class Shim: ShimContentView {

        // MARK: Dependences
        private let analytics: ContentAnalytics
        private let dataBase: DataBase
        private let network: Network
        private let router: Router
        private let logger: Logger

        // MARK: To avoid code duplication, we can pass all reusable systems as a dependency.
        // MARK: To make ViewModel and Shim testable it is needed to keep dependencies as an abstraction.
        init(
            analytics: ContentAnalytics = Analytics.sharedInstance,
            dataBase: DataBase = SQLDataBase(),
            network: Network = BaseNetwork(),
            router: Router = BaseRouter(),
            logger: Logger = BaseLogger()
        ) {
            self.analytics = analytics
            self.dataBase = dataBase
            self.network = network
            self.router = router
            self.logger = logger
        }

        func baseHandling(action: ContentView.Action) {
            analytics.handelContentViewAction(action)
            logger.logAction(action)
        }

        func handleRoute(_ route: ContentRoute) {
            router.handleRoute(route)
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

        func doFinishAction() {
            print("doFinishAction")
        }

        func doLoadAction() async -> [String] {
            sleep(1)
            var result: [String] = []
            for number in 0...1000 {
                result.append("\(number)")
            }
            return result
        }
    }
}
