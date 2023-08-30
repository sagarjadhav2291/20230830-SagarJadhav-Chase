//
//  SJHomeWeatherDetailsView.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 28/08/23.
//

import SwiftUI
let navigationTitle = LocalizedStringKey("home_navigation_title")

struct SJHomeWeatherDetailsView: View {
    private struct Constants {
        let wind = NSLocalizedString("home_wind_title", comment: "Localizable")
        let humidity = NSLocalizedString("home_humidity_title", comment: "Localizable")
        let sunrise = NSLocalizedString("home_sunrise_title", comment: "Localizable")
        let sunset = NSLocalizedString("home_sunset_title", comment: "Localizable")
        let eye = NSLocalizedString("home_eye_title", comment: "Localizable")
        let visibility = NSLocalizedString("home_visibility_title", comment: "Localizable")
        let zero = 0
        let vStackSpacing = CGFloat(3)
        let horizontalPadding = CGFloat(24)
        let verticalPadding = CGFloat(10)
    }
    
    @StateObject var viewModel: SJHomeViewModel
    
    var body: some View {
        
        VStack(spacing: Constants().vStackSpacing) {
            
            SJHomeWeatherDetailsRowView(imageName: Constants().wind, name: Constants().wind.capitalized, value: String(viewModel.viewModel?.wind ?? Constants().zero).appendMPerSecSymbol())
            
            SJHomeWeatherDetailsRowView(imageName: Constants().humidity, name: Constants().humidity.capitalized, value: String(viewModel.viewModel?.humidity ?? Constants().zero).appendPercentageSymbol())

            
            SJHomeWeatherDetailsRowView(imageName: Constants().sunrise, name: Constants().sunrise.capitalized, value: viewModel.stringTimeFromUnix(value: viewModel.viewModel?.sunrise))

            
            SJHomeWeatherDetailsRowView(imageName: Constants().sunset, name: Constants().sunset.capitalized, value: viewModel.stringTimeFromUnix(value: viewModel.viewModel?.sunset))

            
            SJHomeWeatherDetailsRowView(imageName: Constants().eye, name: Constants().visibility.capitalized, value: String(viewModel.viewModel?.visibility ?? Constants().zero).appendMSymbol())

        }
    }
}

struct DetailsTextModifier: ViewModifier {
    private struct Constants {
        let fontSize = CGFloat(18)
    }
    
    func body(content: Content) -> some View {
        content.font(.system(size: Constants().fontSize))
    }
}

struct DetailsImageModifier: ViewModifier {
    private struct Constants {
        let imageSize = CGFloat(18)
    }
    
    func body(content: Content) -> some View {
        content.aspectRatio(contentMode: .fit)
            .frame(width: Constants().imageSize, height: Constants().imageSize)
            .foregroundColor(Color.white)
    }
}

struct SJHomeWeatherDetailsRowView: View {
    private struct Constants {
        let zero = 0
        let horizontalPadding = CGFloat(24)
        let verticalPadding = CGFloat(10)
    }
    
    var imageName: String
    var name: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .modifier(DetailsImageModifier())
            Text(name)
                .modifier(DetailsTextModifier())
            Spacer()
            Text(value)
                .modifier(DetailsTextModifier())
        }.padding(.horizontal, Constants().horizontalPadding)
            .padding(.vertical, Constants().verticalPadding)
        Divider().padding(.horizontal, Constants().horizontalPadding)
    }
}
