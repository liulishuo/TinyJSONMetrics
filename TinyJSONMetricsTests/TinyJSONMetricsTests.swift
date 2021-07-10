//
//  TinyJSONMetricsTests.swift
//  TinyJSONMetricsTests
//
//  Created by liulishuo on 2021/7/4.
//

import XCTest
import SwiftyJSON

class TinyJSONMetricsTests: XCTestCase {

    var jsonData: Data?
    var jsonObject: Any?
    var count = 10000

    override func setUpWithError() throws {

        let file = Bundle.main.path(forResource: "user", ofType: "json")
//        let file = Bundle.main.path(forResource: "weibo", ofType: "json")
        jsonData = try? Data(contentsOf: URL(fileURLWithPath: file!))
        print("jsonData size:", jsonData!.count)

        jsonObject = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSwiftyJSONMemory() throws {

        var json: SwiftyJSON.JSON?

        self.measure(metrics: [XCTMemoryMetric()]) {
            json = try? SwiftyJSON.JSON(data: jsonData!)
        }

        print(json!.dictionaryValue.count)
    }

    func testSwiftyJSONTime() throws {

        var json: SwiftyJSON.JSON?

        self.measure() {
            for _ in (0...count) {
                json = try? SwiftyJSON.JSON(data: jsonData!)
            }
        }

        print(json!.dictionaryValue.count)
    }

    func testSwiftyJSONCopy() throws {

        var json: SwiftyJSON.JSON?
        var array: [SwiftyJSON.JSON] = []
        json = try? SwiftyJSON.JSON(data: jsonData!)

        self.measure() {
            for _ in (0...count) {
                array.append(json!)
            }
        }

        print(json!.dictionaryValue.count)
    }

    func testTinyJSONMemory() throws {

        var json: TinyJSON?

        self.measure(metrics: [XCTMemoryMetric()]) {
            json = TinyJSON(data: jsonData!)
        }

        print(json!.dictionaryValue.count)
    }

    func testTinyJSONTime() throws {

        var json: TinyJSON?

        self.measure() {
            for _ in (0...count) {
                json = TinyJSON(data: jsonData!)
            }
        }

        print(json!.dictionaryValue.count)
    }

    func testTinyJSONCopy() throws {

        var json: TinyJSON?
        var array: [TinyJSON] = []
        json = TinyJSON(data: jsonData!)

        self.measure() {
            for _ in (0...count) {
                array.append(json!)
            }
        }

        print(json!.dictionaryValue.count)
    }

}
