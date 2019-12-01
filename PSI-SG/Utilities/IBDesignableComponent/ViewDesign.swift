//
//  ViewDesign.swift
//
//

import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
    
    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor != nil && backgroundColor!.cgColor.alpha == 0 {
                backgroundColor = oldValue
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var BorderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = BorderColor.cgColor
            
        }
    }
    @IBInspectable var cornerBorder: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerBorder
            self.layer.masksToBounds = cornerBorder<0
        }
    }
    func showBottomShadow (height : Int, color : UIColor) {
        self.layer.shadowOffset = CGSize(width: 0, height: height)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = color.cgColor
    }
}
