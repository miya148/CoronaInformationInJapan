//
//  CovidSingleton.swift
//  CoronaInformationInJapan
//
//  Created by shunsuke.miyano on 2021/07/05.
//

import Foundation

class CovidSingleton {
    
    private init() {}
    static let shared = CovidSingleton()
    var prefecture:[CovidInfo.Prefecture] = []
}
