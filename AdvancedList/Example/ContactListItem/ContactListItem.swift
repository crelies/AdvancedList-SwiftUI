//
//  ContactListItem.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

struct ContactListItem: Identifiable {
    @State private var collapsed: Bool = true
    
    let id: String
    let firstName: String
    let lastName: String
    let streetAddress: String
    let zip: String
    let city: String
    
    var viewRepresentationType: ContactListItemViewRepresentationType = .short
}

extension ContactListItem: View {
    var body: some View {
        Group {
            if viewRepresentationType == .short {
                ContactListItemView(firstName: firstName,
                                    lastName: lastName,
                                    hasMoreInformation: false)
            } else if viewRepresentationType == .detail {
                NavigationLink(destination: ContactDetailView(listItem: self), label: {
                    ContactListItemView(firstName: firstName,
                                        lastName: lastName,
                                        hasMoreInformation: true)
                })
            } else if viewRepresentationType == .collapsable {
                VStack {
                    if collapsed {
                        ContactListItemView(firstName: firstName,
                                            lastName: lastName,
                                            hasMoreInformation: false)
                    } else {
                        ContactDetailView(listItem: self)
                    }
                    
                    Button(action: {
                        self.collapsed.toggle()
                    }) {
                        Text("\(collapsed ? "show" : "hide") details")
                    }.foregroundColor(.blue)
                }
            }
        }
    }
}
