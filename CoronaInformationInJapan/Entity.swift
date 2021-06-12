//
//  Entity.swift
//  CoronaInformationInJapan
//
//  Created by shunsuke.miyano on 2021/06/12.
//

import Foundation

struct CoviInfo: Codable {
    struct Total: Codable {
        var pcr: Int
        var positive: Int
        var hospitalize: Int
        var severe: Int
        var death: Int
        var discharge: Int
    }
}
