//
//  CustomListStateSegmentedControlView.swift
//  AdvancedList
//
//  Created by Christian Elies on 11.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomListStateSegmentedControlView : View {
    private var listState: Binding<ListState>
    private weak var listService: ListService?
    
    var body: some View {
        HStack {
            Button(action: {
                self.listState.value = .items
                
                let items = ExampleDataProvider.randomItems()
                self.listService?.items.removeAll()
                self.listService?.items.append(contentsOf: items)
            }) {
                Text("Items")
            }
            
            Button(action: {
                self.listService?.items.removeAll()
                self.listState.value = .items
            }) {
                Text("Empty")
            }
            
            Button(action: {
                self.listState.value = .loading
            }) {
                Text("Loading")
            }
            
            Button(action: {
                self.listState.value = .error(ExampleError.allCases.randomElement()!)
            }) {
                Text("Error")
            }
        }
    }
    
    init(listState: Binding<ListState>, listService: ListService) {
        self.listState = listState
        self.listService = listService
    }
}
