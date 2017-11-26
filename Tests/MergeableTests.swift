//
//  MergeableTests.swift
//  MergeableTests
//
//  Created by Tatsuya Tanaka on 20171127.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
import Mergeable
//@testable import Mergeable

class MergeableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSimpleMerging() throws {
        struct APIResponse: Codable {
            let id: Int
            let title: String
            let foo: String
        }

        struct APIResponse2: Codable {
            let tags: [String]
        }

        struct Model: Codable, Mergeable {
            let id: Int
            let title: String
            let tags: [String]
        }

        let response = APIResponse(id: 0, title: "にゃーん", foo: "bar")
        let response2 = APIResponse2(tags: ["swift", "ios", "macos"])
        let model = try Model.merge(response, response2)
        XCTAssertEqual(model.id, response.id)
        XCTAssertEqual(model.title, response.title)
        XCTAssertEqual(model.tags, response2.tags)
    }
}
