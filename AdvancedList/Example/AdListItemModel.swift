//
//  AdListItemModel.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

enum AdListItemModelViewRepresentationType: CaseIterable {
    case short
    case long
}

struct AdListItemModel {
    let identifier: String

    let text: String
    var viewRepresentationType: AdListItemModelViewRepresentationType = .short
}

extension AdListItemModel: ListItemProtocol {
    var viewRepresentation: AnyView {
        switch viewRepresentationType {
            case .short:
                return AnyView(
                    NavigationLink(destination: Text(text).lineLimit(nil), label: {
                        Text(text)
                        .lineLimit(1)
                    })
                )
            case .long:
                return AnyView(
                    Text(text)
                        .lineLimit(nil)
                )
        }
    }
}
