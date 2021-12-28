//
//  Section.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 19/08/21.
//
//MARK: - Liders_Book/Info.plist
import UIKit
class Section {
    let title: String
    let img: UIImage
    var isOpened = false
    
    init(title:String, img:UIImage, isOpened:Bool = false){
        self.title = title
        self.isOpened = isOpened
        self.img = img
    }
}
