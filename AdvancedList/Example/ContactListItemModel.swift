//
//  ContactListItemModel.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

enum ContactListItemModelViewRepresentationType: CaseIterable {
    case overview
    case detail
}

struct ContactListItemModel {
    let identifier: String
    
    let firstName: String
    let lastName: String
    let streetAddress: String
    let zip: String
    let city: String
    var viewRepresentationType: ContactListItemModelViewRepresentationType = .overview
}

extension ContactListItemModel: ListItemProtocol {
    var viewRepresentation: AnyView {
        switch viewRepresentationType {
            case .overview:
                return AnyView(
                    HStack {
                        Text(firstName)
                        Text(lastName)
                    }
                )
            case .detail:
                return AnyView(
                    VStack {
                        Text("Detail")
                            .font(.headline)
                        HStack {
                            Text(firstName)
                            Text(lastName)
                        }
                        Text(streetAddress)
                        HStack {
                            Text(zip)
                            Text(city)
                        }
                    }
                )
        }
    }
}
