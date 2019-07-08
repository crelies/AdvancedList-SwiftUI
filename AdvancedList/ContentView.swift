//
//  ContentView.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObjectBinding private var listService: ListService
    private let errorViewProvider: ErrorViewProvider?
    
    var body: some View {
        NavigationView {
            AdvancedList(listService: listService)
                .navigationBarTitle(Text("List of Items"))
                .navigationBarItems(trailing: ListStateChangeButton(listService: listService))
        }
    }
    
    init(errorViewProvider: ErrorViewProvider? = nil) {
        self.errorViewProvider = errorViewProvider
        listService = ListService(errorViewProvider: errorViewProvider)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
