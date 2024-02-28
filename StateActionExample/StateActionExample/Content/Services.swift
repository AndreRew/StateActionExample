//
//  Analytics.swift
//  StateActionExample
//
//  Created by Andrew Kuts on 2024-02-12.
//

import Dufap

class Analytics {

    var loggedActions: [Any] = []

    static let sharedInstance = Analytics()

    private init() { }

}

protocol ContentAnalytics {
    func handelContentViewAction(_ action: ContentView.Action)
}

// MARK: - ContentAnalytics
extension Analytics: ContentAnalytics {

    func handelContentViewAction(_ action: ContentView.Action) {

        switch action {

        case .start, .finish, .openItem, .selectNewPickerValue:
            print("ANALYTICS: this action '\(action)' do not needed to be logged")

        case .loading:
            print("ANALYTICS: log loading action")
            loggedActions.append(action)

        case .itemOpened(let item):
            print("ANALYTICS: log open action \(item)")
            loggedActions.append(action)

        case .buttonAction(let parameter):
            loggedActions.append(action)
            print("ANALYTICS: log button action with value \(parameter)")
        }
    }
}

protocol DataBase { }
struct SQLDataBase: DataBase { }

protocol Network { }
struct BaseNetwork: Network { }

protocol Route { }
struct ContentRoute: Route { }

protocol Router {
    func handleRoute(_ route: Route)
}

protocol Logger {
    func logAction(_ action: ActionProtocol)
}

struct BaseLogger: Logger {
    func logAction(_ action: ActionProtocol) {
        print("LOG: new action `\(action)`")
    }
}

struct BaseRouter: Router {
    func handleRoute(_ route: Route) {
        print("ROUTER: handle route `\(route)`")
    }
}
