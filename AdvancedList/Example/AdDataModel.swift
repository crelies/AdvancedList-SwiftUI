//
//  AdDataModel.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

struct AdDataModel: DataModelProtocol {
    let text: String
    
    let identifier: String = UUID().uuidString
    var rowView: AnyView {
        AnyView(
            NavigationLink(destination: Text(text), label: {
                Text("\(String(text.first ?? "U"))")
            })
        )
    }
}
