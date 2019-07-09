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
    
    var body: some View {
        NavigationView {
            AdvancedList(listService: listService, emptyView: {
                AnyView(Text("Empty"))
            }, errorView: { error in
                AnyView(Text("\(error?.localizedDescription ?? "Error")").lineLimit(nil))
            }) {
                AnyView(Text("Loading"))
            }
            .navigationBarTitle(Text("List of Items"))
            .navigationBarItems(trailing: ListStateChangeButton(listService: listService))
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
