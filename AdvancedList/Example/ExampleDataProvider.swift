//
//  ExampleDataProvider.swift
//  AdvancedList
//
//  Created by Christian Elies on 11.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation

final class ExampleDataProvider {
    private static let listStates: [ListState] = [.error(ExampleError.requestTimedOut),
                                                  .items,
                                                  .loading]
    
    static func randomState() -> ListState {
        var newState = ExampleDataProvider.listStates.randomElement()!
        if case ListState.error = newState {
            newState = .error(ExampleError.allCases.randomElement()!)
        }
        return newState
    }
    
    static func randomItems() -> [ListItemProtocol] {
        let itemCount = Array(5...15).randomElement()!
        let items: [ListItemProtocol] = Array(0...itemCount).map { _ in
            if Bool.random() {
                let id = UUID().uuidString
                let firstName = "Max"
                let lastName = "Mustermann"
                let streetAddress = "Feldstraße 9"
                let zip = "21337"
                let city = "Lüneburg"
                let viewRepresentationType = ContactListItemModelViewRepresentationType.allCases.randomElement()!
                return ContactListItemModel(identifier: id,
                                            firstName: firstName,
                                            lastName: lastName,
                                            streetAddress: streetAddress,
                                            zip: zip,
                                            city: city,
                                            viewRepresentationType: viewRepresentationType)
            } else {
                let id = UUID().uuidString
                let text = "This is a really long and annoying advertisement I really want to get rid off."
                let viewRepresentationType = AdListItemModelViewRepresentationType.allCases.randomElement()!
                return AdListItemModel(identifier: id,
                                       text: text,
                                       viewRepresentationType: viewRepresentationType)
            }
        }
        return items
    }
}
