//
//  ViewController.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Eclectics. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController {
    let dateFormatter = DateFormatter()
    //
    let numberFormatter = NumberFormatter()
    
    weak var frameView: UIView?
    
    let confirmViewsContainer = UIView.init()
    let confirmPINViewsContainer = UIView.init()
    
    //
    var confirmPINTopAnchorContraint: NSLayoutConstraint!
    //
    let screenHeightRatio = GlobalVariables.screenHeightRatio
    //
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //    @IBAction func close(_ sender: UIButton) {
    //        self.dismiss(animated: true, completion: nil)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //
        //self.frameView = self.view.subviews[0]
        //
        //let rootView = self.view.subviews[0]
        //self.frameView = UIView(frame: CGRect(x:0, y:0, width:rootView.bounds.width, height:rootView.bounds.height))
        self.view.tintColor = GlobalVariables.colorAccent
        //
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        for j in view.getAllTextFields() {
            if j.delegate == nil {j.delegate = self}
            //
            if j.keyboardType == .numberPad || j.keyboardType == .decimalPad || j.keyboardType == .phonePad {
                if j.inputAccessoryView == nil {j.inputAccessoryView = createToolBar(j)}
            }
            if j.keyboardType == .default {
                j.returnKeyType = .done
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        self.tabBarController?.tabBar.tintColor = GlobalVariables.colorPrimary
        //
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // workaround for .partialCurl animation bug
        if let list = self.view.gestureRecognizers {
            for guesture in list {
                if NSStringFromClass(type(of:guesture)).hasSuffix("CurlUpTapGestureRecognizer") {
                    guesture.isEnabled = false
                }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureConfirmView(){
        //
    }
    
    func configurePINView(){
        //
    }
    
    @objc dynamic func attemptSubmit(sender:Any?){
        //
        dismissKeyboard()
        donePicker(sender)
        //Clear errors..
        for j in view.getAllTextFields() {
            j.delegate = self
            //
            clearErrorIndicator(j)
        }
        //
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
 
    //
    func setLeftErrorIndicator(_ textField:UITextField?, applyBorder:Bool){
        let leftView = UILabel(frame: CGRect(x: 0, y: 0, width: 32, height: 20));
        //
        leftView.text = "⚠️"
        leftView.sizeToFit()
        //
        leftView.frame = CGRect(x: 10.0, y: 0.0, width: 32, height: 22)
        //
        textField?.leftViewMode = UITextField.ViewMode.always
        textField?.leftView = leftView;
        //
        if applyBorder {
            textField?.layer.borderColor = UIColor.red.cgColor;
            textField?.layer.borderWidth = 1.0;
        }
    }
    //
    func clearErrorIndicator(_ textField:UITextField?){
        textField?.leftView = nil;
        textField?.leftViewMode = UITextField.ViewMode.never
        textField?.layer.borderWidth = 0;
        //
        textField?.borderStyle = .roundedRect
    }
}

extension DefaultViewController{
    //
    func createToolBar(_ anchor:UITextField?)->UIToolbar{
        //
        return createToolBar(anchor,false)
    }
    //
    func createToolBar(_ anchor:UITextField?,_ showCancel:Bool)->UIToolbar{
        //
        return createToolBar(anchor, "Done", showCancel)
    }
    //
    func createToolBar(_ anchor:UITextField?, _ doneTitle:String?,_ showCancel:Bool? )->UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        //toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        //
        toolBar.barTintColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: CGFloat(1))
        toolBar.sizeToFit()
        //
        let doneButton = UIToolBarButton(title: doneTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker(_:)))
        doneButton.inputView = anchor
        //
        let spaceButton = UIToolBarButton(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        //
        if let h = showCancel , h{
            //
            let cancelButton = UIToolBarButton(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPicker(_:)))
            cancelButton.inputView = anchor
            //
            toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        }else{
            toolBar.setItems([spaceButton,doneButton], animated: false)
        }
        toolBar.isUserInteractionEnabled = true
        //
        return toolBar
    }
    
    @objc func donePicker(_ sender:Any?){
        //
        view.endEditing(true)
    }
    
    @objc func cancelPicker(_ sender:Any?){
        //
        if sender is UIToolBarButton, let j = (sender as? UIToolBarButton)?.inputView {
            j.text = nil
        }
        //
        view.endEditing(true)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    ///
    ///
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardHeight: CGFloat = keyboardSize.height * 0.2
        
        let _: CGFloat = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber as! CGFloat
        //
        if let root = self.frameView {
            UIView.animate(withDuration: 0.25, delay: 0.25, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                root.frame = CGRect(x:0, y:(root.frame.origin.y - keyboardHeight), width:self.view.bounds.width, height:self.view.bounds.height)
            }, completion: nil)
        }
        
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        //Height adjustment from bottom
        let keyboardHeight: CGFloat = keyboardSize.height * 0.2
        
        let _: CGFloat = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber as! CGFloat
        //
        if let root = self.frameView {
            UIView.animate(withDuration: 0.25, delay: 0.25, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                root.frame = CGRect(x:0, y:(root.frame.origin.y + keyboardHeight), width:self.view.bounds.width, height:self.view.bounds.height)
            }, completion: nil)
        }
        
    }
    
    
    func validatePhoneNumber(_ phoneNumber:String?)->String?{
        //
        guard var phone = phoneNumber else{
            return nil
        }
        var hasPhoneCode = false
        //
        if phone.isEmpty{
            //
            return nil
        }
        //
        if phone.starts(with: "+"){
            //
            phone = phone.replacingOccurrences(of: "+", with: "")
            //
            hasPhoneCode = true
        }
        //
        if phone.starts(with: "0"){
            //
            phone = String(phone.suffix(from: String.Index(encodedOffset: 1)))
        }
        //
        if phone.lengthOfBytes(using: .utf8) < 7 || phone.lengthOfBytes(using: .utf8) > 15 {
            //
            return nil
        }
        //
        if !hasPhoneCode {
            //
            return "254\(phone)".trimmingCharacters(in: .whitespacesAndNewlines)
        }else{
            return phone.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

extension DefaultViewController:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
}

