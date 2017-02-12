//
//  DownAttributedStringRenderable.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import UIKit
import libcmark

public protocol DownAttributedStringRenderable: DownHTMLRenderable {
    /**
     Generates an `NSAttributedString` from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering

     - throws: `DownErrors` depending on the scenario

     - returns: An `NSAttributedString`
     */
    
    func toAttributedString(_ options: DownOptions) throws -> NSAttributedString
}

public extension DownAttributedStringRenderable {
    /**
     Generates an `NSAttributedString` from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`

     - throws: `DownErrors` depending on the scenario

     - returns: An `NSAttributedString`
     */
    
    public func toAttributedString(_ options: DownOptions = .Default) throws -> NSAttributedString {
        let html = try self.toHTML(options)
        return try NSAttributedString(htmlString: html)
    }
    
    public func toAttributedString(baseFont font: UIFont) throws -> NSAttributedString {
        let html = try self.toHTML(.Default)
        // Apple needs to have the font names mapped so ...
        var fontFamily = font.familyName
        if fontFamily == UIFont.systemFont(ofSize: 10).familyName {
            fontFamily = "-apple-system" // Replacement for system font family name
        }
        let fontedHTML = "<span style=\"font-family: \(fontFamily); font-size: \(font.pointSize)\">\(html)</span>"
        return try NSAttributedString(htmlString: fontedHTML)
       
    }
}
