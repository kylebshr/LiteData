![LiteData Logo](img/LiteData.png)

# LiteData

[![Version](https://img.shields.io/cocoapods/v/LiteData.svg?style=flat)](http://cocoapods.org/pods/LiteData)
[![License](https://img.shields.io/cocoapods/l/LiteData.svg?style=flat)](http://cocoapods.org/pods/LiteData)
[![Platform](https://img.shields.io/cocoapods/p/LiteData.svg?style=flat)](http://cocoapods.org/pods/LiteData)

## About

LiteData provides a very simple core data stack, and a few protocols to make it nice to work with NSManagedObjects and the like. It is heavily influenced by the talk [Modern Core Data](https://realm.io/news/tryswift-daniel-eggert-modern-core-data/) by [Daniel Eggert](https://github.com/danieleggert). 

Because it's so lightweight there are couple caveats:

- NSManagedObject class names *must* match the entity name.
- Though it makes the simple things *very* easy, the more complicated things must be done almost completely manually.

That being said, I'm definitely willing to add more features. This is my first foray into CoreData, so as I use it more, this library will evolve and improve. 

## Documentation

[Jazzy](https://github.com/realm/jazzy) docs available [here](https://kylebshr.github.io/LiteData/).

## Getting Started

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

There's also a `KeyCodable` protocol you can implement if you'd like to, which makes it much easier and safer to work with keys:

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

- Xcode 7.3+
- iOS 9+

## Installation

LiteData is available through CocoaPods and Carthage.

### CocoaPods

```ruby
use_frameworks!

pod "LiteData"
```

### Carthage

```
github "kylebshr/LiteData"
```

## License

LiteData is available under the MIT license. See the LICENSE file for more info.
