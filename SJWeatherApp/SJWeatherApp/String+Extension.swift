//
//  String+Extension.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 28/08/23.
//

import Foundation


extension String {
    func appendDegreeSymbol() -> String {
        self + "°"
    }
    
    func appendPercentageSymbol() -> String {
        self + " %"
    }
    
    func appendMPerSecSymbol() -> String {
        self + " m/s"
    }
    
    func appendMSymbol() -> String {
        self + " m"
    }
    
    static func localizedString(for key: String,
                                    locale: Locale = .current) -> String {
            
        let language = locale.language.languageCode?.identifier
            let path = Bundle.main.path(forResource: language, ofType: "lproj")!
            let bundle = Bundle(path: path)!
            let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
            
            return localizedString
        }
}
