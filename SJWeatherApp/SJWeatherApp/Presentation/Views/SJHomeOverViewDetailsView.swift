//
//  SJHomeOverViewDetailsView.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 29/08/23.
//

import SwiftUI

struct SJHomeOverViewDetailsView: View {
    private struct Constants {
        let cityNameFontSize = CGFloat(24)
        let descriptionFontSize = CGFloat(18)
        let padding = CGFloat(6)
        let defaultValue = Double(0)
        let frameSize = CGFloat(75)
        let defaultCityName =  NSLocalizedString("home_default_cityname", comment: "Localizable")
        let defaultIconName = "rectangle.dashed"
        let defaultDescription = NSLocalizedString("home_default_condition", comment: "Localizable")
    }
    @StateObject var viewModel: SJHomeViewModel

    var body: some View {
        Text(viewModel.viewModel?.name ?? Constants().defaultCityName)
            .font(.system(size: Constants().cityNameFontSize))
        HStack {
            Image(uiImage: (viewModel.viewModel?.iconImage ?? UIImage(systemName: Constants().defaultIconName))!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants().frameSize, height: Constants().frameSize)
            Text(String(viewModel.viewModel?.temp ?? Constants().defaultValue).appendDegreeSymbol())
                .font(.system(size: Constants().cityNameFontSize))
        }
        Text(viewModel.viewModel?.description ?? Constants().defaultDescription)
            .font(.system(size: Constants().descriptionFontSize))
            .padding(Constants().padding)
    }
}
