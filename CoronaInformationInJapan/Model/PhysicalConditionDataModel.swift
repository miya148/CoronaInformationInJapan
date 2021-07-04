//
//  PhysicalConditionData.swift
//  CoronaInformationInJapan
//
//  Created by shunsuke.miyano on 2021/06/29.
//

import Foundation
import RealmSwift

class PhysicalConditionDataModel: Object {
    @objc dynamic var resultMessage: String = ""
    @objc dynamic var resultTitle: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var userID: Int = 0

}
