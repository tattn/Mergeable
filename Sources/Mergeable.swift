//
//  Mergeable.swift
//  Mergeable
//
//  Created by Tatsuya Tanaka on 20171127.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

private let encoder = JSONEncoder()
private let decoder = JSONDecoder()

public protocol Mergeable: Decodable {
    static func mergeFrom<T: Encodable, U: Encodable>(_ value1: T, _ value2: U) throws -> Self
    static func mergeFrom<T: Encodable, U: Encodable, V: Encodable>(_ value1: T, _ value2: U, _ value3: V) throws -> Self
}

public extension Mergeable {
    static func mergeFrom<T: Encodable, U: Encodable>(_ value1: T, _ value2: U) throws -> Self {
        return try merge(from: try [encoder.encode(value1), encoder.encode(value2)])
    }
    static func mergeFrom<T: Encodable, U: Encodable, V: Encodable>(_ value1: T, _ value2: U, _ value3: V) throws -> Self {
        return try merge(from: try [encoder.encode(value1), encoder.encode(value2), encoder.encode(value3)])
    }

    private static func merge(from dataList: [Data]) throws -> Self {
        let jsonArray = try dataList.flatMap { try JSONSerialization.jsonObject(with: $0, options: .allowFragments) as? [String: Any] }
        let mergedJson = jsonArray.reduce(into: [:]) { (result, value) in
            result.merge(value) { (old, _) in old }
        }
        let mergedData = try JSONSerialization.data(withJSONObject: mergedJson, options: [])
        return try decoder.decode(Self.self, from: mergedData)
    }
}
