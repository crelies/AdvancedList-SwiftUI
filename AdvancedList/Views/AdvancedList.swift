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
    
    var body: some View {
        return Group {
            if listService.listState.error != nil {
                listService.errorView(forError: listService.listState.error)
            } else if listService.listState == .items {
                if !listService.dataModels.isEmpty {
                    listService.itemsView
                } else {
                    listService.emptyView
                }
            } else if listService.listState == .loading {
                listService.loadingView
            } else {
                EmptyView()
            }
        }
    }
    
    init(listService: ListService) {
        self.listService = listService
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
        let exampleErrorViewProvider = ExampleErrorViewProvider()
        let listService = ListService(errorViewProvider: exampleErrorViewProvider)
        return NavigationView {
            AdvancedList(listService: listService)
                .navigationBarTitle(Text("List of Items"))
                .navigationBarItems(trailing: ListStateChangeButton(listService: listService))
        }
    }
}
#endif
