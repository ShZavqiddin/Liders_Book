//
//  ReadingVC.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 18/08/21.
//

import UIKit

class ReadingVC: UIViewController {

    
    @IBOutlet weak var readingBackView: UIView!{
        didSet{
            readingBackView.layer.cornerRadius = readingBackView.frame.height/3
        }
    }
    @IBOutlet weak var readingBtn: UIButton!{
        didSet{
            readingBtn.setTitle(Applanguage.getTitle(type: .btn_kitobniOqish), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarBackground()
    }
    
    @IBAction func booksBtnPressed(_ sender: Any) {
        let vc = MainVC(nibName: "MainVC", bundle:nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func readingBtnPressed(_ sender: Any) {
    
        let vc = MainVC(nibName: "MainVC", bundle:nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ReadingVC{
    func navBarBackground(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        navigationItem.hidesBackButton = true
    }
    
}
