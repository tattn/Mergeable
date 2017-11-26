Mergeable
===

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Version](https://img.shields.io/badge/Swift-4-F16D39.svg)](https://developer.apple.com/swift)


Mergeable is a protocol which can merge multiple models.

```swift
struct APIResponse: Encodable {
    let id: Int
    let title: String
    let foo: String
}

struct APIResponse2: Encodable {
    let tags: [String]
}

struct Model: Decodable, Mergeable {
    let id: Int
    let title: String
    let tags: [String]
}

let response = APIResponse(id: 0, title: "にゃーん", foo: "bar")
let response2 = APIResponse2(tags: ["swift", "ios", "macos"])
let model = try Model.mergeFrom(response, response2)
XCTAssertEqual(model.id, response.id)
XCTAssertEqual(model.title, response.title)
XCTAssertEqual(model.tags, response2.tags)
```

## 

# Installation

## Carthage

```ruby
github "tattn/Mergeable"
```


# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

# License

Mergeable is released under the MIT license. See LICENSE for details.
