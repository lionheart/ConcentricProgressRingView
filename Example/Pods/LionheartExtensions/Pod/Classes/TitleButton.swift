//
//  TitleButton.swift
//  LionheartExtensions
//
//  Created by Dan Loewenherz on 4/10/18.
//

import Foundation

public protocol TitleButtonThemeProtocol {
    static var normalColor: UIColor { get }
    static var highlightedColor: UIColor { get }
    static var subtitleColor: UIColor { get }
}

extension TitleButtonThemeProtocol {
    static var centeredParagraphStyle: NSParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.setParagraphStyle(.default)
        style.alignment = .center
        return style
    }
    
    static var normalAttributes: [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: Self.normalColor,
            NSAttributedString.Key.paragraphStyle: centeredParagraphStyle
        ]
    }
    
    static var highlightedAttributes: [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: Self.highlightedColor,
            NSAttributedString.Key.paragraphStyle: centeredParagraphStyle
        ]
    }
    
    static var subtitleAttributes: [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: Self.subtitleColor,
            NSAttributedString.Key.paragraphStyle: centeredParagraphStyle
        ]
    }
}

public final class TitleButton<T>: UIButton where T: TitleButtonThemeProtocol {
    public var enableTitleCopy = false
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return enableTitleCopy && action == #selector(UIApplication.copy(_:))
    }
    
    public override func copy(_ sender: Any?) {
        UIPasteboard.general.string = titleLabel?.text
    }
    
    @objc public convenience init() {
        self.init(frame: .zero)
    }
}

// MARK: - CustomButtonType
extension TitleButton: CustomButtonType {
    public func setTitle(title: String) {
        setTitle(title: title, subtitle: nil)
    }
    
    public func setTitle(title: String, subtitle: String?) {
        let normalString = NSMutableAttributedString(string: title, attributes: T.normalAttributes)
        let highlightedString = NSMutableAttributedString(string: title, attributes: T.highlightedAttributes)
        
        if let subtitle = subtitle {
            normalString.append(NSAttributedString(string: "\n" + subtitle, attributes: T.subtitleAttributes))
            highlightedString.append(NSAttributedString(string: "\n" + subtitle, attributes: T.subtitleAttributes))
            titleLabel?.lineBreakMode = .byWordWrapping
        } else {
            titleLabel?.lineBreakMode = .byTruncatingTail
        }
        
        setAttributedTitle(normalString, for: .normal)
        setAttributedTitle(highlightedString, for: .highlighted)
        
        sizeToFit()
    }
    
    public func startAnimating() {
        fatalError()
    }
    
    public func stopAnimating() {
        fatalError()
    }
}

