//
//  ListService.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class ListService: BindableObject {
    private(set) var items: [AnyListItem] = [] {
        didSet {
            didChange.send()
        }
    }
    
    private(set) var didChange = PassthroughSubject<Void, Never>()
    
    var listState: ListState = .items {
        didSet {
            didChange.send()
        }
    }
    
    func appendItems<Item: Identifiable>(_ items: [Item]) where Item: View {
        let anyListItems = items.map { AnyListItem(item: $0) }
        self.items.append(contentsOf: anyListItems)
    }
    
    func updateItems<Item: Identifiable>(_ items: [Item]) where Item: View {
        let anyListItems = items.map { AnyListItem(item: $0) }
        for anyListItem in anyListItems {
            guard let itemIndex = self.items.firstIndex(where: { $0.id == anyListItem.id }) else {
                continue
            }
            
            self.items[itemIndex] = anyListItem
        }
    }
    
    func removeItems<Item: Identifiable>(_ items: [Item]) where Item: View {
        let anyListItemsToRemove = items.map { AnyListItem(item: $0) }
        self.items.removeAll(where: { item in
             return anyListItemsToRemove.contains { item.id == $0.id }
        })
    }
    
    func removeAllItems() {
        items.removeAll()
    }
}
