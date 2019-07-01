//
//  ListService.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class ListService: BindableObject {
    private weak var emptyViewProvider: EmptyViewProvider?
    private weak var errorViewProvider: ErrorViewProvider?
    private weak var loadingViewProvider: LoadingViewProvider?
    
    private(set) var didChange = PassthroughSubject<Void, Never>()
    
    var listState: ListState = .items {
        didSet {
            didChange.send(())
        }
    }
    
    var dataModels: [DataModelProtocol] = [] {
        didSet {
            didChange.send(())
        }
    }
    
    var itemsView: some View {
        List(dataModels.identified(by: \.identifier)) { dataModel in
            dataModel.rowView
        }
    }
    
    var emptyView: some View {
        emptyViewProvider?.emptyView ?? AnyView(Text("No data available"))
    }
    
    var errorView: some View {
        errorViewProvider?.errorView ?? AnyView(Text("Error"))
    }
    
    var loadingView: some View {
        loadingViewProvider?.loadingView ?? AnyView(Text("Loading"))
    }
    
    init(emptyViewProvider: EmptyViewProvider? = nil,
         errorViewProvider: ErrorViewProvider? = nil,
         loadingViewProvider: LoadingViewProvider? = nil) {
        self.emptyViewProvider = emptyViewProvider
        self.errorViewProvider = errorViewProvider
        self.loadingViewProvider = loadingViewProvider
    }
}
