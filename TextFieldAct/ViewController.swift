//
//  ViewController.swift
//  TextFieldAct
//
//  Created by santhosh on 30/04/18.
//  Copyright © 2018 BINARY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var enterNameTextFeild: UITextField!
    @IBOutlet weak var enterLastNameTextFeild: UITextField!
    @IBOutlet weak var enterContactNoTextFeild: UITextField!
    @IBOutlet weak var districtTextFeild: UITextField!
    @IBOutlet weak var cityTextFeild: UITextField!
    
    
    //Constants
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    let ACCEPTABLE_NUMBERS = "0123456789"
    let REMAINING_CHAR_LENGTH = 1500
    let RESTRICT_CHAR_LENGTH = 254
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterNameTextFeild.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    //MARK:- restric Char
    //UITextView : restric enter max number of characters - upto 1500char
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText: NSString = (textView.text as NSString).replacingCharacters(in: range, with: text) as NSString
        if (textView.textInputMode?.primaryLanguage == "emoji") || !((textView.textInputMode?.primaryLanguage) != nil) {
            return false
        }
        if newText.length <= REMAINING_CHAR_LENGTH {
            //            remainingCharactersCount.text = "Character(s) remaining: \(REMAINING_CHAR_LENGTH - newText.length)"
            return true
        }
        //        remainingCharactersCount.text = "Character(s) remaining: 0"
        textView.text = newText.substring(to: REMAINING_CHAR_LENGTH)
        return false
    }
    
    
    //MARK:- UITextField
    
    //MARK:-  dropDwon: resign
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if districtTextFeild.isFirstResponder  ||  cityTextFeild.isFirstResponder {
            OperationQueue.main.addOperation({() -> Void in
                UIMenuController.shared.setMenuVisible(false, animated: false)
            })
            return super.canPerformAction(action, withSender: sender)
        } else { return true }
    }
    
    //MARK:-  restric ACCEPTABLE_CHARACTERS char and  // restric char Numbers onlyv
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == enterNameTextFeild || textField == enterLastNameTextFeild {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            
            return (string == filtered)
        } else if  textField == enterContactNoTextFeild  {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_NUMBERS).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            
            return (string == filtered)
        }else {
            return true
        }
    }
    
    
    //MARK:- validation
    
    func validTextFeildNil(_ textfeild:UITextField) -> Bool {
        
        let validText = textfeild.text
        if validText?.count == 0 {
            return true
        }else{
            return false
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        
        //    if testStr != "admin"{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        //    }else {
        //     return true
        //    }
    }
    
    //func isValidPhone(value: String) -> Bool {
    //    let PHONE_REGEX = "[0-9]{10}"
    //    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    //    let result =  phoneTest.evaluate(with: value)
    //    return result
    //}
    
    func isValidPhone(value: String) -> Bool {
        let PHONE_REGEX = "^[0-9]{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func isValidPhonewWithPlus91(value: String) -> Bool {
        let PHONE_REGEX = "[+91]{3}[0-9]{10}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    ////password trimming with whitespaces
    func trimmingCharWithWhiteSpaces(_ textFeild:UITextField)->String{
        let trimmTextfeild = textFeild.text?.trimmingCharacters(in: .whitespaces)
        return trimmTextfeild!
    }
    
    //textFeild bottom line
    func addBottomBorder(to textField: UITextField, withBorderColor color: UIColor) {
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: -8, y: textField.frame.size.height + 3, width: textField.frame.size.width, height: 1)
        bottomBorder.backgroundColor = color.cgColor
        textField.layer.addSublayer(bottomBorder)
    }

}

