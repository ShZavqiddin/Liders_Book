//
//  AppLanguage.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 20/08/21.
//
import Foundation

class Applanguage{
   class func getTitle(type: Languages) -> String{
    let language = UserDefaults.standard.string(forKey: Keys.LANGUAGE)
        if language == "rus"{
            return getRusValue(type: type)
        } else if language == "eng"{
            return getEngValue(type: type)
        } else {
           return getUzValue(type: type)
        }
    }
}

//MARK: - UZBEK -
extension Applanguage{
 private class  func getUzValue(type:Languages) -> String {
        switch type {
            case .btn_kirish:
               return "Kirish"
            case .btn_registratsiyadanOtish:
                return "Registratsiyadan o'tish"
            case .btn_tanlash:
                return "Tanlash"
            case .btn_kitobniOqish:
                return "Kitobni o'qish"
            case .btn_send:
                return "Yuborish"
            case .btn_logIn:
                return "Kirish"
            case .lbl_telefonRaqamKiriting:
              return  "Telefon raqamingizni kiriting"
            case .lbl_tilniTanlash:
                return "Tilni tanlang"
            case .lbl_register:
                return "Registratsiya"
            case .lbl_telefonRaqamTF:
                return"Telefon raqamingizni kiriting "
            case .lbl_ism:
                return "Ismingizni kiriting"
            case .lbl_familia:
                return "Familiangizni kiriting"
            case .lbl_sms:
                return "SMS kodni kiriting"
            case .lbl_uzatish:
                return "Uzatish"
            case .lbl_favourites:
                return "Sevimlilar"
            case .lbl_feedBack:
                return "Fikr-mulohaza"
        }
    }
}

//MARK: - RUSSIAN -
extension Applanguage{
 private  class  func getRusValue(type:Languages) -> String {
        switch type {
            case .btn_kirish:
                return "Авторизоваться"
            case .btn_registratsiyadanOtish:
                return "У тебя есть профиль? Подписаться"
            case .btn_tanlash:
                return "Выбор"
            case .btn_kitobniOqish:
                return "Читая книгу"
            case .btn_send:
                return "послать"
            case .btn_logIn:
                return "Авторизоваться"
            case .lbl_telefonRaqamKiriting:
                return "Введите свой номер телефона"
            case .lbl_tilniTanlash:
                return "Выберите язык"
            case .lbl_register:
                return "регистр"
            case .lbl_telefonRaqamTF:
                return "Введите свой номер телефона"
            case .lbl_ism:
                return "Введите свое полное имя"
            case .lbl_familia:
                return "Введите вашу фамилию"
            case .lbl_sms:
                return "Введите смс код"
            case .lbl_uzatish:
                return "Делиться"
            case .lbl_favourites:
                return "Избранное"
            case .lbl_feedBack:
                return "Обратная связь"
        }
    }
}

//MARK: - ENGLISH -
extension Applanguage{
 private class func getEngValue(type:Languages) -> String{
        switch type{
            case .btn_kirish:
                return "Log In"
            case .btn_registratsiyadanOtish:
                return "Do you have a profile Registration"
            case .btn_tanlash:
                return "Selection"
            case .btn_kitobniOqish:
                return "Reading a book"
            case .btn_send:
                return "Send"
            case .btn_logIn:
                return "Log In"
            case .lbl_telefonRaqamKiriting:
                return "Enter your phone number"
            case .lbl_tilniTanlash:
               return "Select a language"
            case .lbl_register:
                return "Register"
            case .lbl_telefonRaqamTF:
               return "Enter your phone number"
            case .lbl_ism:
                return "Enter your full name"
            case .lbl_familia:
                return "Enter your surname"
            case .lbl_sms:
                return "Enter sms code"
            case .lbl_uzatish:
                return "Share"
            case .lbl_favourites:
                return "Favourites"
            case .lbl_feedBack:
                return "FeedBack"
        }
    }
}
enum Languages{
    //MARK: - Button Settitle
    case btn_kirish
    case btn_registratsiyadanOtish
    case btn_tanlash
    case btn_kitobniOqish
    case btn_send
    case btn_logIn
        
    //MARK: - Label.text
    case lbl_telefonRaqamKiriting
    case lbl_tilniTanlash
    case lbl_register
    case lbl_telefonRaqamTF
    case lbl_ism
    case lbl_familia
    case lbl_sms
    case lbl_uzatish
    case lbl_favourites
    case lbl_feedBack
    
}
