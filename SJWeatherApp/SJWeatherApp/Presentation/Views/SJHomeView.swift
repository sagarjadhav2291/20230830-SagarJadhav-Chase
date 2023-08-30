//
//  SJHomeView.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 23/08/23.
//

import SwiftUI

struct SJHomeView: View {
    private struct Constants {
        let navigationTitle = LocalizedStringKey("home_navigation_title")
        let loading = LocalizedStringKey("home_loader_title") 
        let userDefaultsKey = "lastCity"
        let verticalPadding = CGFloat(3)
        let leadingPadding = CGFloat(24)
        let detailsLeadingPadding = CGFloat(120)
        let defaultValue = CGFloat(0)
        let opacity = CGFloat(0.3)
        let scale = CGFloat(1)
        let alertTitle = LocalizedStringKey("home_navigation_title")
        let alertDescription = LocalizedStringKey("home_alert_description")
    }
    @State private var searchText = ""
    @StateObject var viewModel = SJHomeViewModel(locationManager: LocationManager())
    @StateObject var imageCache = ImageCache()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical) {
                    VStack {
                        SearchBarView(text: $searchText) {
                            Task {
                                await viewModel.performSearch(searchText)
                            }
                        }.onChange(of: self.viewModel.currentCity) { newValue in
                            searchText = self.viewModel.currentCity
                        }
                        Spacer().padding(.vertical, Constants().verticalPadding)
                        if verticalSizeClass == .regular {
                            SJHomeOverViewDetailsView(viewModel: viewModel)
                            SJHomeTempDetailsView(viewModel: viewModel)
                            SJHomeWeatherDetailsView(viewModel: viewModel)
                        } else {
                            HStack {
                                VStack {
                                    SJHomeOverViewDetailsView(viewModel: viewModel)
                                    SJHomeTempDetailsView(viewModel: viewModel)
                                }.padding(.leading, Constants().leadingPadding)
                                SJHomeWeatherDetailsView(viewModel: viewModel)
                                    .padding(EdgeInsets(top: Constants().defaultValue, leading: Constants().detailsLeadingPadding, bottom: Constants().defaultValue, trailing: Constants().defaultValue))
                            }
                        }
                    }.padding(5)
                }
                .navigationTitle(Constants().navigationTitle)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .white]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                if viewModel.isLoading {
                    Color.black.opacity(Constants().opacity)
                        .ignoresSafeArea()
                    ProgressView(Constants().loading)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(Constants().scale)
                }
            }
        }.navigationViewStyle(.stack)
            .onChange(of: self.viewModel.dataReceived) { newValue in
                if newValue {
                    if let cachedImage = imageCache.getImage(forKey: viewModel.viewModel?.iconId ?? "") {
                        viewModel.viewModel?.iconImage = cachedImage
                        return
                    }
                    Task {
                        await viewModel.getIcon(icon: viewModel.viewModel?.iconId ?? "") { result in
                        }
                        viewModel.isLoading = false
                    }
                }
                
            }
            .onAppear {
                self.viewModel.locationManager.requestAuthorization()
                if let lastSearchedCity = UserDefaults.standard.string(forKey: Constants().userDefaultsKey) {
                    if lastSearchedCity.isEmpty == true { // defaults don't have any searched city
                        viewModel.getUserCurrentCityWithLocation()
                        searchText = viewModel.currentCity
                        Task {
                            await viewModel.performSearch(searchText)
                        }
                    } else {
                        searchText = lastSearchedCity
                    }
                } else { // defaults don't have any searched city
                    Task {
                        viewModel.getUserCurrentCityWithLocation()
                        searchText = viewModel.currentCity
                    }
                }
            }.alert(isPresented: self.$viewModel.showAlert) {
                Alert(title: Text(Constants().alertTitle),
                      message: Text(Constants().alertDescription))
            }
    }
}
