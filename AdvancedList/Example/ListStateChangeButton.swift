//
//  ListStateChangeButton.swift
//  AdvancedList
//
//  Created by Christian Elies on 10.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

#if DEBUG
struct ListStateChangeButton : View {
    private weak var listService: ListService?
    private var listState: Binding<ListState>
    
    var body: some View {
        Button(action: {
            self.listService?.items.removeAll()
            
            let newState = ExampleDataProvider.randomState()
            if newState == .items {
                if Bool.random() {
                    let items = ExampleDataProvider.randomItems()
                    self.listService?.items.append(contentsOf: items)
                }
            }
            
            self.listState.value = newState
        }, label: {
            Text("Trigger list state change")
        })
    }
    
    init(listService: ListService, listState: Binding<ListState>) {
        self.listService = listService
        self.listState = listState
    }
}
#endif
