//
//  ContentView.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObservedObject private var listService: ListService = ListService()
    
    var body: some View {
        NavigationView {
            return GeometryReader { geometry in
                VStack {
                    CustomListStateSegmentedControlView(listService: self.listService)
                    
                    AdvancedList(listService: self.listService, emptyStateView: {
                        Text("No data")
                    }, errorStateView: { error in
                        Text("\(error?.localizedDescription ?? "Error")").lineLimit(nil)
                    }, loadingStateView: {
                        Text("Loading ...")
                    })
                    .frame(width: geometry.size.width)
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
