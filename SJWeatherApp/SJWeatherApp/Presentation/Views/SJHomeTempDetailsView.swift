//
//  SJHomeTempDetailsView.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 29/08/23.
//

import SwiftUI

struct SJHomeTempDetailsView: View {
    private struct Constants {
        let defaultValue = Double(0)
    }
    @StateObject var viewModel: SJHomeViewModel
    
    var body: some View {
        HStack {
            Text("L: ")
                .modifier(TextModifier())
            Text(String(viewModel.viewModel?.tempMin ?? Constants().defaultValue).appendDegreeSymbol())
                .modifier(TextModifier())
            Text(" | H:")
                .modifier(TextModifier())
            Text(String(viewModel.viewModel?.tempMax ?? Constants().defaultValue).appendDegreeSymbol())
                .modifier(TextModifier())
        }
    }
}

struct TextModifier: ViewModifier {
    private struct Constants {
        let fontSize = CGFloat(18)
    }
    
    func body(content: Content) -> some View {
        content.font(.system(size: Constants().fontSize))
    }
}
