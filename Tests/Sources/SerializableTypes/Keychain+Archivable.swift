//
// File.swift
//
// Created by Andriy Slyusar on 2019-09-29.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation
import Quick
@testable import SwiftyKeychainKit

class KeychainArchivableSpec: QuickSpec, SerializableSpec {
    typealias Serializable = ArchivableValue

    var value: ArchivableValue = ArchivableValue(intProperty: 10)
    var updateValue: ArchivableValue = ArchivableValue(intProperty: 20)
    var defaultValue: ArchivableValue = ArchivableValue(intProperty: 30)

    override func spec() {
        describe("Archivable value") {
            self.testGenericPassword()
            self.testInternetPassword()
        }
    }
}


@objc(ArchivableValue)
class ArchivableValue: NSObject, NSCoding, KeychainSerializable {
    var intProperty: Int

    init(intProperty: Int) {
        self.intProperty = intProperty
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(intProperty, forKey: "intProperty")
    }

    required init?(coder aDecoder: NSCoder) {
        intProperty = aDecoder.decodeInteger(forKey: "intProperty")
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let otherPerson = object as? ArchivableValue else {
            return false
        }
        return self.intProperty == otherPerson.intProperty
    }
}

//@objc(ArchivableMock2)
//private class ArchivableMock2: NSObject, NSCoding {
//    var stringProperty: String
//
//    init(stringProperty: String) {
//        self.stringProperty = stringProperty
//
//        super.init()
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(stringProperty, forKey: "stringProperty")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        stringProperty = aDecoder.decodeObject(forKey: "stringProperty") as! String
//    }
//
//    override func isEqual(_ object: Any?) -> Bool {
//        guard let otherPerson = object as? ArchivableMock2 else {
//            return false
//        }
//        return self.stringProperty == otherPerson.stringProperty
//    }
//}
