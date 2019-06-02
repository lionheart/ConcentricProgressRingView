//
//  ActivityIndicatorButton.swift
//  LionheartExtensions
//
//  Created by Dan Loewenherz on 4/10/18.
//

import Foundation

public final class ActivityIndicatorButton: UIButton {
    var activity: UIActivityIndicatorView!
    
    static let titleAttributes = [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
        ]
    
    static let subtitleAttributes = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11),
        NSAttributedString.Key.foregroundColor: UIColor.darkGray
    ]
    
    @objc convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        activity = UIActivityIndicatorView(style: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activity)
        
        activity.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        activity.centerOnYAxis()
        
        sizeToFit()
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CustomButtonType
extension ActivityIndicatorButton: CustomButtonType {
    public func setTitle(title: String) {
        setTitle(title: title, subtitle: nil)
    }
    
    public func setTitle(title: String, subtitle: String?) {
        let string = NSMutableAttributedString(string: title, attributes: ActivityIndicatorButton.titleAttributes)
        if let subtitle = subtitle {
            string.append(NSAttributedString(string: "\n" + subtitle, attributes: ActivityIndicatorButton.subtitleAttributes))
            titleLabel?.lineBreakMode = .byWordWrapping
        } else {
            titleLabel?.lineBreakMode = .byTruncatingTail
        }
        
        setAttributedTitle(string, for: .normal)
        
        sizeToFit()
    }
    
    public func startAnimating() {
        activity.startAnimating()
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
    }
    
    public func stopAnimating() {
        activity.stopAnimating()
        
        contentEdgeInsets = .zero
    }
}
