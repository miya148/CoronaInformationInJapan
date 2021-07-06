//
//  Entity.swift
//  CoronaInformationInJapan
//
//  Created by shunsuke.miyano on 2021/06/12.
//

import Foundation

struct CovidInfo: Codable {
    // Codable API通信等で取得したJSONやプロパティリストを任意のデータ型に変換するプロトコル
    struct Total: Codable {
        var pcr: Int
        var positive: Int
        var hospitalize: Int
        var severe: Int
        var death: Int
        var discharge: Int
    }
    
    struct Prefecture: Codable {
        var id: Int
        var name_ja: String
        var cases: Int
        var deaths: Int
        var pcr: Int
    }
}
