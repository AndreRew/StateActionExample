# StateActionExample
This is an example of how we can separate UI presentation data (State) and actions (Action) from view.

Advantages of using it: 
1. The UI can be updated from any thread because all updates will be automatically directed to the Main thread inside Dufap lib. 
3. Declarative UI. All benefits from using SwiftUI and binding UI are available.
4. Using the Combine will not be a problem. From the View Model side, it's not allowed to misuse it. However, inside of Actions functionality, it's possible to use Combine or any other data-driving things.
5. Functional programming is the main thing. The communication between the View and ViewModel is restricted by Action functionality.
6. Very intuitive use. All data flows are projected to be changed but easily extended.

Disadvantages: 
1. Upon initial inspection, it may seem complex.

## View:
- Concept of view is present Content (Data) on the screen.
- Another responsibility is to handle user actions or life cycles.

## ViewModel:
- The main responsibility  of the ViewModel is only two things:
- Firstly provide data for view and keep it updated. The `@Published var state: State` is responsible for it.
- Handle actions from the View. The function `func trigger(action: Action)` is responsible for it. 
- Any other thing is out of scope for ViewModel.

## State:
- The purpose of the State is to be a container for all representation Data.

## Action: 
- It is a simple enum, that describes API to View. 
