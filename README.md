# LiteData

[![Version](https://img.shields.io/cocoapods/v/LiteData.svg?style=flat)](http://cocoapods.org/pods/LiteData)
[![License](https://img.shields.io/cocoapods/l/LiteData.svg?style=flat)](http://cocoapods.org/pods/LiteData)
[![Platform](https://img.shields.io/cocoapods/p/LiteData.svg?style=flat)](http://cocoapods.org/pods/LiteData)

## Example

LiteData provides an easy to use core data stack with sensible defaults. Creating a stack is as simple as telling it the model name:

```swift
var stack: LiteStack!
	
do {
	try stack = LiteStack(modelName: "Model")
} catch {
	fatalError("Error setting up stack: \(error)")
}
```

Conforming to `ManagedObjectType` gives your NSManagedObjects the power of LiteData. Return some default descriptors, and you get effortless fetch requests and fetched results controllers:

```swift
extension Post: ManagedObjectType {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "date", ascending: true)]
    }
}

/* Later */

// Create a post
let post: Post = stack.context.insert()

// Create a fetched results controller
let frc = stack.context.sortedFetchedResults(ofType: Post.self)

// Get a simple fetch request
let request = Post.sortedFetchRequest
```

There's also a `KeyCodable` protocol you can implement if you'd like to, which makes it much easier to work with keys:

```swift
extension Post: KeyCodable {
    enum Key: String {
        case text
        case likes
        case date
        case identifier
    }
}

/* Later */

extension Post: ManagedObjectType {
    static var defaultSortDescriptors: [NSSortDescriptor] {
    	 let dateDescriptor = NSSortDescriptor(key: Key.date.rawValue, ascending: true)
    	 let likesDescriptor = NSSortDescriptor(key: Key.likes.rawValue, ascending: true)
        return [dateDescriptor, likesDescriptor]
    }
}
```
 

## Requirements

## Installation

LiteData is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LiteData"
```

## Author

Kyle Bashour, kylebshr@me.com

## License

LiteData is available under the MIT license. See the LICENSE file for more info.
