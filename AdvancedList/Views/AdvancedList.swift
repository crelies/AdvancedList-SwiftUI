//
//  AdvancedList.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct AdvancedList : View {
    @ObjectBinding private var listService: ListService
    private let emptyView: () -> AnyView
    private let errorView: (Error?) -> AnyView
    private let loadingView: () -> AnyView
    
    var body: some View {
        return Group {
            if listService.listState.error != nil {
                errorView(listService.listState.error)
            } else if listService.listState == .items {
                if !listService.dataModels.isEmpty {
                    List(listService.dataModels.identified(by: \.identifier)) { dataModel in
                        dataModel.rowView
                    }
                } else {
                    emptyView()
                }
            } else if listService.listState == .loading {
                loadingView()
            } else {
                EmptyView()
            }
        }
    }
    
    init(listService: ListService, @ViewBuilder emptyView: @escaping () -> AnyView, @ViewBuilder errorView: @escaping (Error?) -> AnyView, @ViewBuilder loadingView: @escaping () -> AnyView) {
        self.listService = listService
        self.emptyView = emptyView
        self.errorView = errorView
        self.loadingView = loadingView
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
            let newState = self.listStates.randomElement()!
            if newState == .items {
                if Bool.random() {
                    self.listService?.dataModels.removeAll()
                } else {
                    self.listService?.dataModels.removeAll()
                    let dataModels = Array(0...5).map { ContactDataModel(firstName: "FirstName \($0)", lastName: "LastName \($0)") }
                    self.listService?.dataModels.append(contentsOf: dataModels)
                }
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
            AdvancedList(listService: listService, emptyView: {
                AnyView(Text("No data"))
            }, errorView: { error in
                AnyView(
                    VStack {
                        Text(error?.localizedDescription ?? "Error")
                            .lineLimit(nil)
                        
                        Button(action: {
                            // do something
                        }) {
                            Text("Retry")
                        }
                    }
                )
            }) {
                AnyView(Text("Loading ..."))
            }
            .navigationBarTitle(Text("List of Items"))
            .navigationBarItems(trailing: ListStateChangeButton(listService: listService))
        }
    }
}
#endif
