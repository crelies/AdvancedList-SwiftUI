//
//  ExampleErrorViewProvider.swift
//  AdvancedList
//
//  Created by Christian Elies on 08.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

final class ExampleErrorViewProvider: ErrorViewProvider {
    func errorView(forError error: Error?) -> AnyView {
        let errorMessage = error?.localizedDescription ?? "Error"
        
        return AnyView(
            VStack {
                Text(errorMessage)
                    .lineLimit(nil)
                
                Button(action: {
                    // do something
                }) {
                    Text("Retry")
                }
            }
        )
    }
}
