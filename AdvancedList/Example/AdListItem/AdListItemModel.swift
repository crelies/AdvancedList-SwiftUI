//
//  AdListItemModel.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

struct AdListItemModel {
    let id: String
    let text: String
    var viewRepresentationType: AdListItemModelViewRepresentationType = .short
}

extension AdListItemModel: ListItem {
    var viewRepresentation: some View {
        Group {
            if viewRepresentationType == .short {
                NavigationLink(destination: AdDetailView(text: text), label: {
                    Text(text)
                        .lineLimit(1)
                })
            } else if viewRepresentationType == .long {
                Text(text)
                    .lineLimit(nil)
            }
        }
    }
}
