//
//  SearchBarView.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 29/08/23.
//

import SwiftUI

struct SearchBarView: View {
    private struct Constants {
        let cornerRadius = CGFloat(8)
        let padding = CGFloat(6)
        let searchImage = "magnifyingglass"
        let cityTextfieldPlaceholder = LocalizedStringKey("home_search_placeholder")
        let buttonTitle = LocalizedStringKey("home_search_title")
    }
    
    @Binding var text: String
    let onSearchButtonTapped: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: Constants().searchImage)
            TextField(Constants().cityTextfieldPlaceholder,
                      text: $text,
                      onEditingChanged: { _ in
            }, onCommit: {})
            .foregroundColor(.primary)
            Button(action: onSearchButtonTapped) {
                Text(Constants().buttonTitle)
            }.foregroundColor(.blue)
        }
        .padding(EdgeInsets(top: Constants().padding, leading: Constants().padding, bottom: Constants().padding, trailing: Constants().padding))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(Constants().cornerRadius)
        .padding(.horizontal)
    }
}
