//
//  ContentView.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import AdvancedList
import SwiftUI

struct ContentView : View {
    private let listService = ListService()
    
    var body: some View {
        NavigationView {
            return GeometryReader { geometry in
                VStack {
                    CustomListStateSegmentedControlView()
                        .environmentObject(self.listService)
                    
                    AdvancedList(listService: self.listService, emptyStateView: {
                        Text("No data")
                    }, errorStateView: { error in
                        Text("\(error.localizedDescription)").lineLimit(nil)
                    }, loadingStateView: {
                        Text("Loading ...")
                    }, pagination: .noPagination)
                    .frame(width: geometry.size.width)
                }
                .navigationBarTitle(Text("List of Items"))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
