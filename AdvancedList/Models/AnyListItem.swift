//
//  AnyListItem.swift
//  AdvancedList
//
//  Created by Christian Elies on 12.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

struct AnyListItem: Identifiable, View {
    let id: AnyHashable
    let body: AnyView
    
    init<T: Identifiable>(item: T) where T: View {
        id = item.id
        body = AnyView(item)
    }
}
