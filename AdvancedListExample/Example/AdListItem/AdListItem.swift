//
//  AdListItem.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

struct AdListItem: Identifiable {
    @State private var isImageCollapsed: Bool = true
    
    let id: String
    let text: String
    var viewRepresentationType: AdListItemViewRepresentationType = .short
}

extension AdListItem: View {
    var body: some View {
        Group {
            if viewRepresentationType == .short {
                NavigationLink(destination: AdDetailView(text: text), label: {
                    Text(text)
                        .lineLimit(1)
                    Text("ℹ️")
                })
            } else if viewRepresentationType == .long {
                Text(text)
                    .lineLimit(nil)
            } else if viewRepresentationType == .image {
                VStack {
                    if !isImageCollapsed {
                        Image("restaurant")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    }
                    
                    Button(action: {
                        self.isImageCollapsed.toggle()
                    }) {
                        Text("\(isImageCollapsed ? "show" : "hide") image")
                    }.foregroundColor(.blue)
                }
            }
        }
    }
}
