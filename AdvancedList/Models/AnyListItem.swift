//
//  AnyListItem.swift
//  AdvancedList
//
//  Created by Christian Elies on 12.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

struct AnyListItem: ListItem {
    let id: AnyHashable
    let viewRepresentation: AnyView
    
    init<T: ListItem>(item: T) {
        id = item.id
        viewRepresentation = AnyView(item.viewRepresentation)
    }
}
