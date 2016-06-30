//
//  UIMultilineLabel.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 2/21/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

public class MultilineLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        numberOfLines = 0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}