//
//  ExampleDataProvider.swift
//  AdvancedList
//
//  Created by Christian Elies on 11.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

final class ExampleDataProvider {
    static func randomItems() -> [AnyListItem] {
        let itemCount = Array(5...15).randomElement()!
        let items: [AnyListItem] = Array(0...itemCount).map { _ in
            if Bool.random() {
                let id = UUID().uuidString
                let firstName = "Max"
                let lastName = "Mustermann"
                let streetAddress = "Feldstraße 9"
                let zip = "21337"
                let city = "Lüneburg"
                let viewRepresentationType = ContactListItemModelViewRepresentationType.allCases.randomElement()!
                let itemModel = ContactListItemModel(id: id,
                                                     firstName: firstName,
                                                     lastName: lastName,
                                                     streetAddress: streetAddress,
                                                     zip: zip,
                                                     city: city,
                                                     viewRepresentationType: viewRepresentationType)
                return AnyListItem(item: itemModel)
            } else {
                let id = UUID().uuidString
                let text = "This is a really long and annoying advertisement I really want to get rid off."
                let viewRepresentationType = AdListItemModelViewRepresentationType.allCases.randomElement()!
                let itemModel = AdListItemModel(id: id,
                                                text: text,
                                                viewRepresentationType: viewRepresentationType)
                return AnyListItem(item: itemModel)
            }
        }
        return items
    }
}
