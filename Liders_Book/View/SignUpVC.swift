//
//  SignUpVC.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 17/08/21.
//

import UIKit
import FlagPhoneNumber

class SignUpVC: UIViewController {
    
    @IBOutlet weak var signInBtn: UIButton!{
        didSet{
            signInBtn.setTitle(Applanguage.getTitle(type: .btn_kirish), for: .normal)
        }
    }
    @IBOutlet weak var btnHeight: NSLayoutConstraint!{
        didSet{
            if isSmalScreen {
                btnHeight.constant = 0.2
            }
        }
    }
    
    @IBOutlet weak var entryLbl: UILabel!{
        didSet{
            entryLbl.text = Applanguage.getTitle(type: .lbl_telefonRaqamKiriting)
            
            if isSmalScreen {
                entryLbl.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            }
        }
    }
    
    @IBOutlet weak var registerBtn: UIButton!{
        didSet{
            registerBtn.setTitle(Applanguage.getTitle(type: .btn_registratsiyadanOtish), for: .normal)
            if isSmalScreen{
                registerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 5, weight:.regular)
            }
        }
    }
    
    @IBOutlet weak var stackTopHeight: NSLayoutConstraint!{
        didSet{
            if isSmalScreen{
                stackTopHeight.constant = 50
            }
        }
    }
    
    @IBOutlet weak var phoneNumber: FPNTextField!{
        didSet{
            phoneNumber.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarBackground()
        setupTextField()
        registerKeyboardNotifications()
        tapGesture()
        
        UserDefaults.standard.setValue(true, forKey: Keys.isLogged)
        
    }
    
    func setupTextField(){
        phoneNumber.set(phoneNumber: "998")
        phoneNumber.leftViewMode = .always
        phoneNumber.flagButtonSize = CGSize(width: 50, height: 60)
        phoneNumber.setFlag(key: .UZ)
        phoneNumber.setFlag(countryCode: .UZ)
        phoneNumber.placeholder = " 123 45 67"
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func registrationBtnPressed(_ sender: Any) {
        let vc = RegistrationVC(nibName: "RegistrationVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if phoneNumber.text!.isEmpty{
            Alert.showAlert(forState: .warning, message: "Telefon raqamingizni kiriting")
        } else {
            let vc = LanguageVC(nibName: "LanguageVC", bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SignUpVC{
    func navBarBackground(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded();      self.navigationItem.hidesBackButton = true
    }
}
extension SignUpVC: FPNTextFieldDelegate{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        //
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        //
    }
    
    func fpnDisplayCountryList() {
        //
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.count == 9{
            textField.isEnabled = false
            textField.isUserInteractionEnabled = false
        }
        else{
            textField.isEnabled = true
            textField.isUserInteractionEnabled = true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 12
    }
}
//MARK: - Keyboard Handling
extension SignUpVC {
    
    func registerKeyboardNotifications() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let _ = keyboardInfo.cgRectValue.size
        
        
        UIView.animate(withDuration: 0.5) {
            if isSmalScreen {
                self.view.transform = CGAffineTransform(translationX: 0, y: -100)
            }else{
                self.view.transform = CGAffineTransform(translationX: 0, y: -50)
            }
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.view.transform = .identity
        }
    }
    
}
extension SignUpVC{
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        if UIScreen.main.bounds.height < 650 {
            signInBtn.layer.cornerRadius = signInBtn.frame.height/3
        }else {
            signInBtn.layer.cornerRadius = signInBtn.frame.height/2
        }
    }
}
extension SignUpVC {
    func userSignIn(){
        let params  = [
            "phone_number" : phoneNumber.text!
        ]
        
        UserDefaults.standard.setValue(phoneNumber.text, forKey: "phone")
        Net.req(urlAPI:"/client/sign-in", method: .post, params: params) {[self] data in
            if let data = data {
                print("\(params)🇺🇿")
                print(data)
                if data["code"].intValue == 0 {
                    //                    let vc = OTPVC(nibName: "OTPVC", bundle: nil)
                    //                    navigationController?.pushViewController(vc, animated: true)
                }else if data["code"].intValue == 11000{
                    //                    let vc = SignUpPage(nibName: "SignUpPage", bundle: nil)
                    //                    vc.phone_number = phoneNumberTextField.text ?? ""
                    //                    navigationController?.pushViewController(vc, animated: true)
                }else{
                    Alert.showAlert(forState: .error, message: data["message"].stringValue)
                }
            }
        }
    }
}
