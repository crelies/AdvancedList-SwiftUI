//
//  ContactListItemModel.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

struct ContactListItemModel {
    let id: String
    let firstName: String
    let lastName: String
    let streetAddress: String
    let zip: String
    let city: String
    var viewRepresentationType: ContactListItemModelViewRepresentationType = .overview
}

extension ContactListItemModel: ListItem {
    var viewRepresentation: some View {
        Group {
            if viewRepresentationType == .overview {
                HStack {
                    Text(firstName)
                    Text(lastName)
                }
            } else if viewRepresentationType == .detail {
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
            }
        }
    }
}
