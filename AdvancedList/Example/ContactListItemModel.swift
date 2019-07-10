//
//  ContactListItemModel.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

struct ContactListItemModel: ListItemProtocol {
    let firstName: String
    let lastName: String
    
    var identifier: String = UUID().uuidString
    var viewRepresentation: AnyView {
        AnyView(
            NavigationLink(destination: Text("\(firstName) \(lastName)"), label: {
                Text("\(String(firstName.first ?? "F")). \(String(lastName.first ?? "L")).")
            })
        )
    }
}
