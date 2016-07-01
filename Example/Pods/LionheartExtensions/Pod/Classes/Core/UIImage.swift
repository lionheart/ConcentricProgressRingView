//
//  UIImage.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation
import Photos

public enum UIImageFormat {
    case PNG
    case JPEG(quality: CGFloat)
}

public enum UIImageSaveError: ErrorType {
    case Unspecified
}

public extension UIImage {
    /**
     Initialize a `UIImage` as a screenshot of the provided `UIView`.

     - parameter view: The `UIView` to take the screenshot of.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: March 9, 2016
     */
    convenience init?(view: UIView) {
        let bounds = view.bounds

        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        view.drawViewHierarchyInRect(bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let data = UIImagePNGRepresentation(image) {
            self.init(data: data)
        }
        else {
            return nil
        }
    }

    /**
     Initialize a `UIImage` with a base64 data URL.

     - parameter view: The `UIView` to take the screenshot of.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: March 9, 2016
     */
    convenience init?(base64DataURLString: String?) {
        guard let base64DataURLString = base64DataURLString where base64DataURLString == "" else {
            self.init()
            return nil
        }

        if let range = base64DataURLString.rangeOfString("base64,"),
            index = range.last,
            data = NSData(base64EncodedString: base64DataURLString.substringFromIndex(index.successor()), options: NSDataBase64DecodingOptions()) {
            self.init(data: data)
        }
        else {
            self.init()
            return nil
        }
    }

    /**
     Return a new image with the provided color blended into it.
     
     - parameter color: The color to blend into the image.
     - returns: A `UIImage` with the color applied as a tint.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, .Normal)
        CGContextClipToMask(context, rect, CGImage)
        color.setFill()
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
     Return a new image with the alpha applied to the current one.
     
     - parameter alpha: A float specifying the alpha level of the generated image.
     - returns: A `UIImage` with the alpha applied.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func imageWithAlpha(alpha: Float) -> UIImage {
        let alpha = CGFloat(alpha)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let area = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        CGContextScaleCTM(context, 1, -1)
        CGContextTranslateCTM(context, 0, -area.size.height)
        CGContextSetBlendMode(context, .Multiply)
        CGContextSetAlpha(context, alpha)
        CGContextDrawImage(context, area, CGImage)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
     Crop a given image to the specified `CGRect`.
     
     - parameter rect: the `CGRect` to crop the image to.
     - returns: A `UIImage` with the crop applied.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func imageByCroppingToRect(rect: CGRect) -> UIImage? {
        if let CIImage = CIImage {
            let image = CIImage.imageByCroppingToRect(rect)
            return UIImage(CIImage: image)
        }
        else {
            return nil
        }
    }

    /**
     Return a screenshot of the current screen as a `UIImage`.
     
     - returns: The screenshot represented as a `UIImage`.
     - note:
        Original Source: [Apple Developer Documentation](https://developer.apple.com/library/ios/qa/qa1703/_index.html#//apple_ref/doc/uid/DTS40010193)
    
     Edited By: [http://stackoverflow.com/a/8017292/39155](http://stackoverflow.com/a/8017292/39155)
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    class func screenshot() -> UIImage {
        let imageSize = UIScreen.mainScreen().bounds.size
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        for window in UIApplication.sharedApplication().windows {
            CGContextSaveGState(context)
            CGContextTranslateCTM(context, window.center.x, window.center.y)
            CGContextConcatCTM(context, window.transform)
            CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y)
            
            switch UIApplication.sharedApplication().statusBarOrientation {
            case .LandscapeLeft:
                CGContextRotateCTM(context, CGFloat(M_PI_2))
                CGContextTranslateCTM(context, 0, -imageSize.width)
                break
                
            case .LandscapeRight:
                CGContextRotateCTM(context, -CGFloat(M_PI_2))
                CGContextTranslateCTM(context, -imageSize.height, 0)
                break
                
            case .PortraitUpsideDown:
                CGContextRotateCTM(context, CGFloat(M_PI))
                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height)
                break
                
            default:
                break
            }
            
            window.drawViewHierarchyInRect(window.bounds, afterScreenUpdates: false)
            CGContextRestoreGState(context)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func saveToFile(path: String, format: UIImageFormat) throws {
        var data: NSData?
        switch format {
        case .PNG:
            data = UIImagePNGRepresentation(self)
            
        case .JPEG(let quality):
            data = UIImageJPEGRepresentation(self, quality)
        }

        if let data = data {
            data.writeToFile(path, atomically: true)
        }
        else {
            throw UIImageSaveError.Unspecified
        }
    }
    
    @available(iOS 9.0, *)
    func saveToCameraRoll(completion: ((Bool, NSError?) -> Void)?) throws {
        let library = PHPhotoLibrary.sharedPhotoLibrary()
        library.performChanges({
            PHAssetCreationRequest.creationRequestForAssetFromImage(self)
        }) { (success, error) in
            if let completion = completion {
                completion(success, error)
            }
        }
    }
}