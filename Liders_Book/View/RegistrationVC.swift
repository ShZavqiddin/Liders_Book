//
//  RegistrationVC.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 18/08/21.
//

import UIKit
let isSmalScreen = UIScreen.main.bounds.height < 650

class RegistrationVC: UIViewController {
    @IBOutlet weak var registerLbl: UILabel!{
        didSet{
            registerLbl.text = Applanguage.getTitle(type: .lbl_register)
            
            if isSmalScreen {
                registerLbl.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            }
        }
    }
    @IBOutlet weak var textFieldStackView: UIStackView!{
        didSet{
            if isSmalScreen {
                textFieldStackView.spacing = 10
            }
        }
    }
    
    @IBOutlet weak var stacksSpacing: NSLayoutConstraint!
    @IBOutlet weak var phoneNumber: PulBackTF!{
        didSet{
            phoneNumber.title = Applanguage.getTitle(type: .lbl_telefonRaqamTF)
            phoneNumber.textFont = .systemFont(ofSize: 18)
            phoneNumber.keyboardType = .numbersAndPunctuation
            if isSmalScreen {
                fullName.textFont = .systemFont(ofSize: 15)
            }
        }
    }
    @IBOutlet weak var fullName: PulBackTF!{
        didSet{
            fullName.title = Applanguage.getTitle(type: .lbl_ism)
            if isSmalScreen {
                fullName.textFont = .systemFont(ofSize: 15)
            }else{
                fullName.textFont = .systemFont(ofSize: 18)
            }
        }
    }
    @IBOutlet weak var surname: PulBackTF!{
        didSet{
            surname.title = Applanguage.getTitle(type: .lbl_familia)
            surname.textFont = .systemFont(ofSize: 18)
            if isSmalScreen {
                fullName.textFont = .systemFont(ofSize: 15)
            }
        }
    }
    
    @IBOutlet weak var otp: PulBackTF!{
        didSet{
            otp.delegate = self
            otp.title = Applanguage.getTitle(type: .lbl_sms)
            otp.textFont = .systemFont(ofSize: 18)
            otp.keyboardType = .numberPad
            if isSmalScreen {
                fullName.textFont = .systemFont(ofSize: 15)
            }
        }
    }
    
    
    @IBOutlet weak var sendBtn: UIButton!{
        didSet{
            sendBtn.setTitle(Applanguage.getTitle(type: .btn_send), for: .normal)
            
            sendBtn.layer.cornerRadius = sendBtn.frame.height/10
        }
    }
    
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!{
        didSet{
            if isSmalScreen{
                textFieldHeight.constant = 16
            }
        }
    }
    
    @IBOutlet weak var logInBtn: UIButton!{
        didSet{
            logInBtn.setTitle(Applanguage.getTitle(type: .btn_logIn), for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarBackground()
        registerKeyboardNotifications()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if fullName.text!.isEmpty || surname.text!.isEmpty || phoneNumber.text!.isEmpty {
            Alert.showAlert(forState: .warning, message: "Ma'lumotlarni to'ldiring")
        }
        else if otp.text!.isEmpty{
            Alert.showAlert(forState: .warning, message: "SMS kodni kiriting")
        }
        else{
            let vc = ReadingVC(nibName:"ReadingVC", bundle:nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func logInBtnPressed(_ sender: Any) {
        let vc = SignUpVC(nibName:"SignUpVC", bundle:nil)
        navigationController?.popViewController(animated: true)
    }
    
}

extension RegistrationVC{
    func navBarBackground(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        navigationItem.hidesBackButton = true
    }
    
}
extension RegistrationVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = self.otp.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 4
        
    }
}
//MARK: - Keyboard Handling

extension RegistrationVC {
    
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
                self.view.transform = CGAffineTransform(translationX: 0, y: -60)
            }
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.view.transform = .identity
        }
    }
    
}
extension RegistrationVC{
    func sendUser(){
        let params = [
            "full_name" : fullName.text!,
            "surname_name" : surname.text!,
            "phone_number" : phoneNumber.text!
        ] as [String : Any]
        
        Net.req(urlAPI: "client/sign-up", method: .post, params: params) {[self] (data) in
            if let data = data{
                print(data)
                if data["message"].stringValue == "Succes"{
//                    let vc = OTPVC(nibName: "OTPVC", bundle: nil)
//                    vc.number = self.phone_number
//                    navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    Alert.showAlert(forState: .error, message:data["message"].stringValue)
                }
            }
        }
    }
   
}
