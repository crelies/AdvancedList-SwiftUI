//
//  ContentView.swift
//  AdvancedListExample
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import AdvancedList
import SwiftUI

struct ContentView : View {
    @State private var items = ExampleDataProvider.randomItems()
    @State private var listState: ListState = .items

    var body: some View {
        NavigationView {
            return GeometryReader { geometry in
                VStack {
                    CustomListStateSegmentedControlView(listState: self.$listState,
                                                        items: self.$items)
                    
                    AdvancedList(self.items, content: { item in
                        self.view(for: item)
                    }, listState: self.$listState, emptyStateView: {
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

extension ContentView {
    private func view(for identifiable: AnyIdentifiable) -> AnyView {
        if let contactListItem = identifiable.value as? ContactListItem {
            return AnyView(ContactListItemView(contactListItem: contactListItem))
        } else if let adListItem = identifiable.value as? AdListItem {
            return AnyView(AdListItemView(adListItem: adListItem))
        } else {
            return AnyView(EmptyView())
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
