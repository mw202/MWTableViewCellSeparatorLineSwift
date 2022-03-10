//
//  MWTableViewCellExtension.swift
//  MWTableViewCellSeparatorLineSwift
//
//  Created by LiY on 2022/3/10.
//

import Foundation

extension UITableViewCell {
    
    /// 分隔线样式
    public enum SeparatorLineStyle {
        /// 显示
        case display(SeparatorLineDisplayStyle)
        /// 颜色
        case color(UIColor)
        /// 高度
        case height(CGFloat)
        
        public static func ==(lhs: SeparatorLineStyle, rhs: SeparatorLineStyle) -> Bool {
            switch (lhs, rhs) {
            case let (.display(d1), .display(d2)):
                switch (d1, d2) {
                case (.hidden, .hidden): return true
                case let (.show(l1, r1), .show(l2, r2)): return l1 == l2 && r1 == r2
                default: break
                }
                return false
            case let (.color(c1), .color(c2)): return c1 == c2
            case let (.height(h1), .height(h2)): return h1 == h2
            default: break
            }
            
            return false
        }
    }
    
    /// 分隔线显示样式
    public enum SeparatorLineDisplayStyle {
        case hidden
        case show(l: CGFloat, r: CGFloat)
    }
    
    /// 设置分隔线样式
    /// - Parameter items: [SeparatorLineStyle]
    public func setSeparatorLineStyle(_ items: [SeparatorLineStyle]) {
        
        let idViewAndContentViewLeft = "cell.view.contentview.left"
        let idViewAndContentViewRight = "cell.view.contentview.right"
        let idViewAndContentViewBottom = "cell.view.contentview.bottom"
        let idViewHeight = "cell.view.height"
        let separatorViewTag = 2046
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude)
        
        var separatorView = self.viewWithTag(separatorViewTag)
        if separatorView == nil {
            separatorView = UIView(frame: .zero)
            separatorView!.tag = separatorViewTag
            self.addSubview(separatorView!)
            self.bringSubview(toFront: separatorView!)
        }
            
        separatorView!.translatesAutoresizingMaskIntoConstraints = false
        
        // 1.先移除
        self.removeConstraints(ids: [idViewAndContentViewLeft, idViewAndContentViewRight, idViewAndContentViewBottom])
        separatorView!.removeConstraint(id: idViewHeight)
        
        // 约束-left
        let layoutLeft = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: separatorView!, attribute: .left, multiplier: 1, constant: -20) // 默认20
        layoutLeft.identifier = idViewAndContentViewLeft
        
        // 约束-right
        let layoutRight = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: separatorView!, attribute: .right, multiplier: 1, constant: 0)
        layoutRight.identifier = idViewAndContentViewRight
        
        // 约束-height
        let layoutHeight = NSLayoutConstraint(item: separatorView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        layoutHeight.identifier = idViewHeight
        
        // 约束-bottom
        let layoutBottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: separatorView!, attribute: .bottom, multiplier: 1, constant: 0)
        layoutBottom.identifier = idViewAndContentViewBottom
        
        // 2.再添加
        self.addConstraints([layoutLeft, layoutRight, layoutBottom])
        separatorView!.addConstraint(layoutHeight)
        
        // 背景色
        if #available(iOS 13.0, *) {
            separatorView!.backgroundColor = .opaqueSeparator
        } else {
            // Fallback on earlier versions
            separatorView!.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 200/255, alpha: 1)
        }
        
        // 如果包含有隐藏属性，忽略其他设置
        if items.contains(where: { $0 == .display(.hidden) }) {
            separatorView!.isHidden = true
        } else {
            separatorView!.isHidden = false
            
            for item in items {
                switch item {
                case .display(let display):
                    switch display {
                    case .hidden: break
                    case .show(let left, let right):
                        let viewLeft = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: separatorView!, attribute: .left, multiplier: 1, constant: -left)
                        viewLeft.identifier = idViewAndContentViewLeft
                        self.updateConstraint(id: idViewAndContentViewLeft, constraint: viewLeft)
                        
                        let viewRight = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: separatorView!, attribute: .right, multiplier: 1, constant: right)
                        viewRight.identifier = idViewAndContentViewRight
                        self.updateConstraint(id: idViewAndContentViewRight, constraint: viewRight)
                    }
                case .color(let color):
                    separatorView!.backgroundColor = color
                case .height(let height):
                    let viewHeight = NSLayoutConstraint(item: separatorView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
                    viewHeight.identifier = idViewHeight
                    separatorView!.updateConstraint(id: idViewHeight, constraint: viewHeight)
                }
            }
        }
    }
}

extension UIView {
    
    /// 根据identifier查找约束
    /// - Parameters:
    ///   - id: identifier
    /// - Returns: 查找结果
    func findConstraint(id: String) -> NSLayoutConstraint? {
        return self.constraints.first(where: { $0.identifier == id })
    }
    
    /// 根据identifier更新约束
    /// - Parameters:
    ///   - id: identifier
    ///   - constraint: 新的约束
    func updateConstraint(id: String, constraint: NSLayoutConstraint) {
        if let c = findConstraint(id: id) {
            self.removeConstraint(c)
            self.addConstraint(constraint)
        }
    }
    
    /// 根据identifier删除约束
    /// - Parameters:
    ///   - id: identifier
    func removeConstraint(id: String) {
        if let c = findConstraint(id: id) {
            self.removeConstraint(c)
        }
    }
    
    /// 根据多个identifier删除约束
    /// - Parameters:
    ///   - ids: [identifier]
    func removeConstraints(ids: [String]) {
        for id in ids {
            removeConstraint(id: id)
        }
    }
}
