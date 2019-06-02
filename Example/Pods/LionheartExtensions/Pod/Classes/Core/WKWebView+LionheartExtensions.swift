//
//  WKWebView+LionheartExtensions.swift
//  LionheartExtensions
//
//  Created by Dan Loewenherz on 5/30/18.
//

import WebKit

/// Helper methods for WKWebView
public extension WKWebView {
    /// Loads an HTTP request with the specified cookies
    func load(_ request: URLRequest, with cookies: [HTTPCookie]) {
        var request = request
        let headers = HTTPCookie.requestHeaderFields(with: cookies)
        for (name, value) in headers {
            request.addValue(value, forHTTPHeaderField: name)
        }
        
        load(request)
    }
}
