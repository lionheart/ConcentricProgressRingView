//
//  Copyright 2017 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

public extension UIPrintPageRenderer {
    var PDF: Data {
        let data = NSMutableData()

        UIGraphicsBeginPDFContextToData(data, paperRect, nil)
        prepare(forDrawingPages: NSMakeRange(0, numberOfPages))
        let bounds = UIGraphicsGetPDFContextBounds()
        for i in 0..<numberOfPages {
            UIGraphicsBeginPDFPage()
            drawPage(at: i, in: bounds)
        }

        UIGraphicsEndPDFContext()
        return data as Data
    }

    convenience init(formatter: UIViewPrintFormatter, paperSize: CGSize, insets: UIEdgeInsets) {
        self.init()

        addPrintFormatter(formatter, startingAtPageAt: 0)

        let printableRect = CGRect(x: insets.left, y: insets.top, width: paperSize.width - insets.left - insets.right, height: paperSize.height - insets.top - insets.bottom)
        let paperRect = CGRect(origin: CGPoint.zero, size: paperSize)

        setValue(NSValue(cgRect: paperRect), forKey: "paperRect")
        setValue(NSValue(cgRect: printableRect), forKey: "printableRect")
    }
}

