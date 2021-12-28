//
//  LanguageVC.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 18/08/21.
//

import UIKit
import Lottie
class LanguageVC: UIViewController{
    
    @IBOutlet weak var selectionBtn: UIButton!{
        didSet{
            selectionBtn.setTitle(Applanguage.getTitle(type: .btn_tanlash), for: .normal)
            
            if isSmalScreen {
                selectionBtn.layer.cornerRadius = selectionBtn.frame.height/3
            }else{
                selectionBtn.layer.cornerRadius = selectionBtn.frame.height/2
            }
        }
    }
    
    @IBOutlet weak var selectLanguageLbl: UILabel!{
        didSet{
            selectLanguageLbl.text = Applanguage.getTitle(type:.lbl_tilniTanlash)
        }
    }
    @IBOutlet weak var languageTF: UITextField!
    
    @IBOutlet weak var animation: AnimationView!
    
    
    var pickerView = UIPickerView()
    var pickerViewData = ["Ozbek", "Русский", "English"]
    
    var currentLanguage : LanguageEnum = .uzbek
    var lang = UserDefaults.standard.string(forKey: Keys.LANGUAGE) ?? "uz"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarBackground()
        toolbar()
        registerKeyboardNotifications()
        pickerView.backgroundColor = .systemTeal
        pickerView.delegate = self
        pickerView.dataSource = self
        languageTF.inputView = pickerView
        UserDefaults.standard.setValue(lang, forKey: Keys.LANGUAGE)
        animation.isHidden = true
    
    }
    
    func toolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolbar.isTranslucent = true
        let selectedBtn = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectBtnPressed))
        let spaceBtn =  UIBarButtonItem(systemItem: .flexibleSpace)
        selectedBtn.tintColor = .black
        languageTF.inputAccessoryView = toolbar
        toolbar.items = [spaceBtn,selectedBtn]
    }
    @objc func selectBtnPressed() {
        languageTF.resignFirstResponder()
        
        if languageTF.text == pickerViewData[0]{
            lang = "uz"
        }
        if languageTF.text == pickerViewData[1]{
            lang = "rus"
        }
        if languageTF.text == pickerViewData[2]{
            lang = "eng"
        }
    }
    
    @IBAction func selectionBtnPressed(_ sender: Any) {
        if languageTF.text!.isEmpty{
            Alert.showAlert(forState: .warning, message: "Tilni tanlang")
        }else{
            UserDefaults.standard.setValue(lang, forKey: Keys.LANGUAGE)
            Loader.start()
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
                Loader.stop()
                let window = UIApplication.shared.keyWindow
                let nav = UINavigationController(rootViewController: ReadingVC(nibName: "ReadingVC", bundle: nil))
                window?.rootViewController = nav
                window?.makeKeyAndVisible()
        }

        }
    }
    
}
extension LanguageVC{
    func navBarBackground(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
}
extension LanguageVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerViewData[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var currentLang: LanguageEnum = .uzbek
        if row == 2{
            currentLang = .english
        }  else if row == 1{
            currentLang = .rus
        }  else if row == 0{
            currentLang = .uzbek
        }
        
        if currentLang == .uzbek {
            self.languageTF.backgroundColor = .systemIndigo
            self.languageTF.text = "Ozbek"
        } else if currentLang == .rus {
            self.languageTF.backgroundColor = .systemYellow
            self.languageTF.text = "Русский"
        } else if currentLang == .english{
            self.languageTF.backgroundColor = .systemGreen
            self.languageTF.text = "English"
        }
        self.currentLanguage = currentLang
        
    }
}
extension LanguageVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
//MARK: - Keyboard Handling
extension LanguageVC {
    
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
    
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
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
