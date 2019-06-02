//
//  CustomButtonType.swift
//  LionheartExtensions
//
//  Created by Dan Loewenherz on 4/10/18.
//

import Foundation

public protocol CustomButtonType {
    func setTitle(title: String)
    func setTitle(title: String, subtitle: String?)
    func sizeToFit()
    func startAnimating()
    func stopAnimating()
}
