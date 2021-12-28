//
//  ProfileVC.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 18/08/21.
//

import UIKit
import MessageUI
import StoreKit
protocol MenuDelegate {
    func backTo()
}


class ProfileVC: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    @IBOutlet weak var table_view: UITableView!{
        didSet{
            table_view.delegate = self
            table_view.dataSource = self
            table_view.separatorStyle = .none
            table_view.register(ProfileCell.nib(), forCellReuseIdentifier: ProfileCell.identifier)
            table_view.rowHeight = 50
        }
    }
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var hidBtn: UIButton!
    
    
    let namesArrEng = [
        "Share",
        "Favourites",
        "Feedback"
    ]
    let namesArrUz = [
        "Uzatish",
        "Sevimlilar",
        "Fikr-mulohaza"
    ]
    let namesRusArr = [
        "Делиться",
        "Избранное",
        "Обратная связь"
    ]
    let imagesArr = [
        UIImage(named: "share")!,
        UIImage(named: "like")!,
        UIImage(named: "favourites")!
    ]
    
    var delegate: MenuDelegate?
    var lang = UserDefaults.standard.string(forKey: Keys.LANGUAGE) ?? "uz"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.transform = CGAffineTransform(translationX: -animationView.bounds.width, y: 0)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {[self] in
            animationView.transform = .identity
            
        }
    }
    
    @IBAction func hidBtnPressed(_ sender: Any) {
        self.delegate?.backTo()
        UIView.animate(withDuration: 1) {
            self.animationView.transform = CGAffineTransform(translationX: -self.animationView.bounds.width, y: 0)
            
        }completion: { (_) in
            
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    @IBAction func signOutBtnPressed(_ sender: Any) {
        Cache.saveUserToken(token: nil)
       if let window = UIApplication.shared.keyWindow{
        let nav = UINavigationController(rootViewController: SignUpVC(nibName: "SignUpVC", bundle: nil))
        window.rootViewController = nav
    }
    
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        namesArrUz.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_view.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        cell.selectionStyle = .none
        if isSmalScreen{
            cell.lbl.font = UIFont.systemFont(ofSize: 15)
        }
        if lang == "eng"{
            cell.updateCell(image: imagesArr[indexPath.row], label: namesArrEng[indexPath.row])
        }
        else if lang == "rus"{
            cell.updateCell(image: imagesArr[indexPath.row], label: namesRusArr[indexPath.row])
        }else{
            cell.updateCell(image: imagesArr[indexPath.row], label: namesArrUz[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let urlStr = NSURL(string: "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8") {
                let objectsToShare = [urlStr]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    if let popup = activityVC.popoverPresentationController {
                        popup.sourceView = self.view
                        popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                    }
                }
                
                self.present(activityVC, animated: true, completion: nil)
            }
        }
        if indexPath.row == 2{
            feedBack()
        }
        
        
    }
}
extension ProfileVC : UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
extension ProfileVC {
    func feedBack(){
        let alert = UIAlertController(title: "Feedback", message: "Are you enjoying the app", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiis", style: .cancel, handler: nil)
        let yes = UIAlertAction(title: "Yes, I love it ", style: .default) { [weak self]_ in
            guard let scene = self!.view.window?.windowScene else {
                print("no scane")
                return
            }
            SKStoreReviewController.requestReview(in: scene)
        }
        let no = UIAlertAction(title: "No, this sucks!", style: .default) { (_) in
            // collect feedback
            //Prompt user to email you
            // Open safari to your contact page
        }
        
        alert.addAction(dismiss)
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
}
