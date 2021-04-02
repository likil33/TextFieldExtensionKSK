//
//  Extension.swift
//  TextFieldAct
//
//  Created by santhosh on 30/04/18.
//  Copyright © 2018 BINARY. All rights reserved.
//

import Foundation
import UIKit




//===============================================================================//

// restrict the characters
@IBDesignable class CustomTexView: UITextView, UITextViewDelegate {
    
    @IBInspectable var maximumCharacters: Int = 15 {
        didSet {
            //            limitCharacters1()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //        maximumCharacters()
        self.delegate = self
        
        //        addTarget(self, action: #selector(CustomTexView.limitCharacters1), for: .editingChanged)
    }
    private func textView(_ textView: CustomTexView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText: NSString = (textView.text as NSString).replacingCharacters(in: range, with: text) as NSString
        if (textView.textInputMode?.primaryLanguage == "emoji") || !((textView.textInputMode?.primaryLanguage) != nil) {
            return false
        }
        
        if newText.length <= 15 {
            //            remainingCharactersCount.text = "Character(s) remaining: \(REMAINING_CHAR_LENGTH - newText.length)"
            return true
        }
        //        remainingCharactersCount.text = "Character(s) remaining: 0"
        textView.text = newText.substring(to: 15)
        return false
    }
    
    //    func textViewDidEndEditing(_ CustomTexView: UITextView) {
    //
    //        limitCharacters1()
    //    }
    //
    //    @objc func limitCharacters1() {
    //        guard text != nil else {
    //            return
    //        }
    //        if (text?.count)! > maximumCharacters {
    //            if let range = text?.index(before: (text?.endIndex)!) {
    //                //                text = text?.substring(to: range)
    //                //                let newStr = String(str[..<index]) // Swift 4
    //                text = String(text![..<range])
    //            }
    //        }
    //    }
}



//===============================================================================//


@IBDesignable
class DesignableUITextFieldRight: UITextField {
    
    // Provides left padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightPadding
        return textRect
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = rightImage {
            rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: color])
    }
}

//===============================================================================//

@IBDesignable
class TextFieldWithPadding: UITextField {
    
    @IBInspectable var horizontalInset: CGFloat = 0
    @IBInspectable var verticalInset: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: verticalInset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset , dy: verticalInset)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: verticalInset)
    }
}

//===============================================================================//

@IBDesignable class MaxLengthTextField: UITextField {
    
    @IBInspectable
    var defaultText: String? {
        get { return self.text }
        set { self.text = newValue }
    }
    
    @IBInspectable var maximumCharacters: Int = 13 {
        didSet {
            maxChars()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        maxChars()
        //        let bottomBorder = CALayer()
        //        bottomBorder.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: SCREEN_WIDTH - 196, height: 1)
        //        bottomBorder.backgroundColor = LIGHT_GRAY_COLOR.cgColor
        //        self.layer.addSublayer(bottomBorder)
        self .reloadInputViews()
        addTarget(self, action: #selector(MaxLengthTextField.maxChars), for: .editingChanged)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if (self .isFirstResponder) {
            OperationQueue.main.addOperation({() -> Void in
                UIMenuController.shared.setMenuVisible(false, animated: false)
            })
            return super.canPerformAction(action, withSender: sender)
        } else { return true }
    }
    @objc func maxChars() {
        guard text != nil else {
            return
        }
        
        if (text?.count)! > maximumCharacters {
            if let range = text?.index(before: (text?.endIndex)!) {
                text = String(text![..<range])
            }
        } else if (text?.count)! < 4 {
            if (maximumCharacters != 6) { text = "+91" }
        }
        
    }
}


//===============================================================================//

//===============================================================================//

//===============================================================================//


//===============================================================================//

//===============================================================================//

//===============================================================================//

//===============================================================================//

