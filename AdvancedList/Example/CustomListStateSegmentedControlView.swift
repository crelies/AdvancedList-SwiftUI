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
    private weak var listService: ListService?
    
    var body: some View {
        HStack {
            Button(action: {
                self.listService?.listState = .items
                
                let items = ExampleDataProvider.randomItems()
                self.listService?.removeAllItems()
                self.listService?.appendItems(items)
            }) {
                Text("Items")
            }
            
            Button(action: {
                self.listService?.removeAllItems()
                self.listService?.listState = .items
            }) {
                Text("Empty")
            }
            
            Button(action: {
                self.listService?.listState = .loading
            }) {
                Text("Loading")
            }
            
            Button(action: {
                self.listService?.listState = .error(ExampleError.allCases.randomElement()!)
            }) {
                Text("Error")
            }
        }
    }
    
    init(listService: ListService) {
        self.listService = listService
    }
}
