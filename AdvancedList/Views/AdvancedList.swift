//
//  AdvancedList.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct AdvancedList<EmptyStateView: View, ErrorStateView: View, LoadingStateView: View> : View {
    @ObjectBinding private var listService: ListService
    private let emptyStateView: () -> EmptyStateView
    private let errorStateView: (Error?) -> ErrorStateView
    private let loadingStateView: () -> LoadingStateView
    
    private var listState: Binding<ListState>
    
    var body: some View {
        return Group {
            if listState.value.error != nil {
                errorStateView(listState.value.error)
            } else if listState.value == .items {
                if !listService.items.isEmpty {
                    List(listService.items.identified(by: \.identifier)) { item in
                        item.viewRepresentation
                    }
                } else {
                    emptyStateView()
                }
            } else if listState.value == .loading {
                loadingStateView()
            } else {
                EmptyView()
            }
        }
    }
    
    init(listService: ListService, listState: Binding<ListState>, @ViewBuilder emptyStateView: @escaping () -> EmptyStateView, @ViewBuilder errorStateView: @escaping (Error?) -> ErrorStateView, @ViewBuilder loadingStateView: @escaping () -> LoadingStateView) {
        self.listService = listService
        self.listState = listState
        self.emptyStateView = emptyStateView
        self.errorStateView = errorStateView
        self.loadingStateView = loadingStateView
    }
}

#if DEBUG
struct AdvancedList_Previews : PreviewProvider {
    @State private static var listState: ListState = .items
    
    static var previews: some View {
        let listService = ListService()
        
        return NavigationView {
            AdvancedList(listService: listService, listState: $listState, emptyStateView: {
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
            .navigationBarItems(trailing: ListStateChangeButton(listService: listService, listState: $listState))
        }
    }
}
#endif
