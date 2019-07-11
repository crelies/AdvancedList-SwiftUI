//
//  ContentView.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObjectBinding private var listService: ListService = ListService()
    @State private var listState: ListState = .items
    
    var body: some View {
        NavigationView {
            return GeometryReader { geometry in
                VStack {
                    CustomListStateSegmentedControlView(listState: self.$listState, listService: self.listService)
                    
                    AdvancedList(listService: self.listService, listState: self.$listState, emptyStateView: {
                        Text("No data")
                    }, errorStateView: { error in
                        Text("\(error?.localizedDescription ?? "Error")").lineLimit(nil)
                    }) {
                        Text("Loading ...")
                    }.frame(width: geometry.size.width,
                            height: geometry.size.height)
                }
                .navigationBarTitle(Text("List of Items"))
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
