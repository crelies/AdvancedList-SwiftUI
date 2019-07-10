//
//  AdvancedList.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct AdvancedList<EmptyStateView, ErrorStateView, LoadingStateView> : View where EmptyStateView: View, ErrorStateView: View, LoadingStateView: View {
    @ObjectBinding private var listService: ListService
    private let emptyStateView: () -> EmptyStateView
    private let errorStateView: (Error?) -> ErrorStateView
    private let loadingStateView: () -> LoadingStateView
    
    var body: some View {
        return Group {
            if listService.listState.error != nil {
                errorStateView(listService.listState.error)
            } else if listService.listState == .items {
                if !listService.items.isEmpty {
                    List(listService.items.identified(by: \.identifier)) { dataModel in
                        dataModel.viewRepresentation
                    }
                } else {
                    emptyStateView()
                }
            } else if listService.listState == .loading {
                loadingStateView()
            } else {
                EmptyView()
            }
        }
    }
    
    init(listService: ListService, @ViewBuilder emptyStateView: @escaping () -> EmptyStateView, @ViewBuilder errorStateView: @escaping (Error?) -> ErrorStateView, @ViewBuilder loadingStateView: @escaping () -> LoadingStateView) {
        self.listService = listService
        self.emptyStateView = emptyStateView
        self.errorStateView = errorStateView
        self.loadingStateView = loadingStateView
    }
}

#if DEBUG
struct ListStateChangeButton : View {
    private weak var listService: ListService?
    private let listStates: [ListState] = [.error(ExampleError.requestTimedOut),
                                           .items,
                                           .loading]
    
    var body: some View {
        Button(action: {
            var newState = self.listStates.randomElement()!
            if newState == .items {
                if Bool.random() {
                    self.listService?.items.removeAll()
                } else {
                    self.listService?.items.removeAll()
                    let itemCount = Array(5...15).randomElement()!
                    let items: [ListItemProtocol] = Array(0...itemCount).map { number in
                        if Bool.random() {
                            return ContactListItemModel(firstName: "FirstName \(number)", lastName: "LastName \(number)")
                        } else {
                            return AdListItemModel(text: "Your Advertisement here \(number)")
                        }
                    }
                    self.listService?.items.append(contentsOf: items)
                }
            } else if case ListState.error = newState {
                newState = .error(ExampleError.allCases.randomElement()!)
            }
            
            self.listService?.listState = newState
        }, label: {
            Text("Trigger list state change")
        })
    }
    
    init(listService: ListService) {
        self.listService = listService
    }
}

struct AdvancedList_Previews : PreviewProvider {
    static var previews: some View {
        let listService = ListService()
        return NavigationView {
            AdvancedList(listService: listService, emptyStateView: {
                Text("No data")
            }, errorStateView: { error in
                VStack {
                    Text(error?.localizedDescription ?? "Error")
                        .lineLimit(nil)
                    
                    Button(action: {
                        // do something
                    }) {
                        Text("Retry")
                    }
                }
            }) {
                Text("Loading ...")
            }
            .navigationBarTitle(Text("List of Items"))
            .navigationBarItems(trailing: ListStateChangeButton(listService: listService))
        }
    }
}
#endif
