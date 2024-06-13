# MWTableViewCellSeparatorLine for Swift

[![CI Status](https://img.shields.io/travis/LiY/MWTableViewCellSeparatorLineSwift.svg?style=flat)](https://travis-ci.org/LiY/MWTableViewCellSeparatorLineSwift)
[![Version](https://img.shields.io/cocoapods/v/MWTableViewCellSeparatorLineSwift.svg?style=flat)](https://cocoapods.org/pods/MWTableViewCellSeparatorLineSwift)
[![License](https://img.shields.io/cocoapods/l/MWTableViewCellSeparatorLineSwift.svg?style=flat)](https://cocoapods.org/pods/MWTableViewCellSeparatorLineSwift)
[![Platform](https://img.shields.io/cocoapods/p/MWTableViewCellSeparatorLineSwift.svg?style=flat)](https://cocoapods.org/pods/MWTableViewCellSeparatorLineSwift)

## 说明

swift版本的UITableViewCell分割线

<img src="/screenshots/screenshot1.png" width="50%" height="50%">

## 使用

```swift

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // ...
    cell.setSeparatorLineStyle([.display(.show(l: 0, r: 20)), .color(UIColor.red), .height(0.5)])
    
    // 或者颜色使用字符串形式
    // .color("#3125FF")
}

```
## 注意
* 如果`UITableView`设置了`Style` 为 `grouped`，仍然会有上下2条线，需要设置
```swift
tableView.separatorStyle = .none
```

## Installation

MWTableViewCellSeparatorLineSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MWTableViewCellSeparatorLineSwift'
```

## Author

LiY, 250230331@qq.com

## License

MWTableViewCellSeparatorLineSwift is available under the MIT license. See the LICENSE file for more info.
