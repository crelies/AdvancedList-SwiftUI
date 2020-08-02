//
//  ContentView.swift
//  AdvancedListExample
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import AdvancedList
import SwiftUI

struct ContentView: View {
    @State private var items = ExampleDataProvider.randomItems()
    @State private var listState: ListState = .items
    @State private var paginationState: AdvancedListPaginationState = .idle

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    CustomListStateSegmentedControlView(
                        listState: $listState,
                        items: $items
                    )
                    
                    AdvancedList(items, content: { item in
                        view(for: item)
                    }, listState: $listState, emptyStateView: {
                        Text("No data")
                    }, errorStateView: { error in
                        Text("\(error.localizedDescription)").lineLimit(nil)
                    }, loadingStateView: {
                        if #available(iOS 14.0, *) {
                            ProgressView()
                        } else {
                            Text("Loading ...")
                        }
                    })
                    .pagination(.init(type: .lastItem, shouldLoadNextPage: loadNextItems) {
                        switch paginationState {
                        case .idle:
                            EmptyView()
                        case .loading:
                            HStack {
                                Spacer()

                                if #available(iOS 14.0, *) {
                                    ProgressView()
                                } else {
                                    Text("Loading ...")
                                }

                                Spacer()
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(16)
                            .padding(.horizontal)

                        case let .error(error):
                            HStack {
                                Spacer()
                                VStack(spacing: 8) {
                                    Text(error.localizedDescription)
                                        .foregroundColor(.red)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.center)

                                    Button(action: {
                                        loadNextItems()
                                    }) {
                                        Text("Retry")
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                    })
                    .frame(width: geometry.size.width)
                }
                .navigationTitle(Text("List of Items"))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

private extension ContentView {
    @ViewBuilder func view(for identifiable: AnyIdentifiable) -> some View {
        if let contactListItem = identifiable.value as? ContactListItem {
            ContactListItemView(contactListItem: contactListItem)
        } else if let adListItem = identifiable.value as? AdListItem {
            AdListItemView(adListItem: adListItem)
        } else {
            EmptyView()
        }
    }

    func loadNextItems() {
        paginationState = .loading

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if Bool.random() {
                items.append(contentsOf: ExampleDataProvider.randomItems())
                paginationState = .idle
            } else {
                paginationState = .error(ExampleError.requestTimedOut as NSError)
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
