# SwiftLevelDB
Swift binding for LevelDB

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate SwiftLevelDB into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "0x73/SwiftLevelDB"
```

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SwiftLevelDB into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'SwiftLevelDB'
```

### Usage

```swift
import SwiftLevelDB

// Create a database.
let database = LevelDB(databaseName: databaseName)

// Write
database["name"] = "sedat gokbek"
database["lastname"] = "ciftci"

// Get value
let name = database["name"]!
let lastname = database["lastname"]!
```


## Author

Sedat Gokbek CIFTCI, me@sedat.ninja

## License

SwiftLevelDB is available under the MIT license. See the LICENSE file for more info.

## Contributing

1. Fork it (http://github.com/0x73/SwiftLevelDB/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
