//
//  MainVC.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 18/08/21.
//

import UIKit
import SafariServices
import MessageUI
import AVFoundation
import AVKit
import EpubViewerKit

class MainVC: UIViewController{
    
    @IBOutlet weak var table_view: UITableView!{
        didSet{
            table_view.delegate = self
            table_view.dataSource = self
            table_view.register(CheptersCell.nib(), forCellReuseIdentifier: CheptersCell.identifier)
            table_view.register(CollapsCell.nib(), forCellReuseIdentifier: CollapsCell.identifier)
            table_view.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    
    @IBOutlet weak var animationView: UIView!
    
    
    var player: AVAudioPlayer?
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Liderlar Kitobi"
        navigationBar()
        


        //Set up models
        sections = [
            Section(title: "Birinchi bo'lim", img: UIImage(systemName: "1.circle.fill")!),
            Section(title: "Ikkinchi bo'lim", img: UIImage(systemName: "2.circle.fill")!),
            Section(title: "Uchinchi bo'lim", img: UIImage(systemName: "3.circle.fill")!),
            Section(title: "To'rtinchi bo'lim", img: UIImage(systemName: "4.circle.fill")!),
            Section(title: "Beshinchi bo'lim", img: UIImage(systemName: "5.circle.fill")!),
            Section(title: "Oltinchi bo'lim", img: UIImage(systemName: "6.circle.fill")!),
            Section(title: "Yettinchi bo'lim", img: UIImage(systemName: "7.circle.fill")!),
            Section(title: "Xamma ko'rishi shart bo'lgan videolar", img: UIImage(systemName: "8.circle.fill")!)
        ]
        
    }
    
    
    
    
    @IBAction func segmentControllPressed(_ sender: Any) {
        //        switch segmentedControll.selectedSegmentIndex{
        //            case 0:
        //
        //        }
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        if section.isOpened {
            return 2
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = table_view.dequeueReusableCell(withIdentifier: CheptersCell.identifier, for: indexPath) as! CheptersCell
            cell.updateCell(section: sections[indexPath.section].title, number: sections[indexPath.section].img)
            if isSmalScreen{
                cell.sectionLbl.font = UIFont.systemFont(ofSize: 15)
            }
            return cell
        }
        else{
            let cell = table_view.dequeueReusableCell(withIdentifier: CollapsCell.identifier, for: indexPath) as! CollapsCell
            cell.delegate = self
            cell.index = indexPath
            return cell
        }
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table_view.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
        table_view.reloadSections([indexPath.section], with: .none)
    }
}


//MARK: - Setup NavigationController, NavigationBar
extension MainVC{
    func navigationBar() {
        let operatorBar = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(operatorBarTapped))
        navigationItem.leftBarButtonItem = operatorBar
    }
    
    @objc func operatorBarTapped(){
        let vc = ProfileVC(nibName: "ProfileVC", bundle: nil)
        vc.delegate = self
        navigationController?.navigationBar.isHidden = true
        vc.modalPresentationStyle = .overFullScreen
        UIView.animate(withDuration: 1) {
            self.view.transform = CGAffineTransform(translationX: self.view.frame.width / 2, y: 0).scaledBy(x: 0.75, y: 0.7)
            self.animationView.clipsToBounds = true
            self.view.clipsToBounds = true
            self.view.layer.cornerRadius = 20
            self.animationView.layer.cornerRadius = 20
            
        }
        present(vc, animated: false, completion: nil)
    }
}


extension MainVC: MenuDelegate{
    func backTo() {
        UIView.animate(withDuration: 1) {
            self.view.transform = .identity
            self.animationView.layer.cornerRadius = 0
            self.navigationController?.navigationBar.isHidden = false
        }completion: { (_) in
            self.tabBarController?.tabBar.isHidden = false
        }
    }
}
extension MainVC: CollapsCellDelegate, MFMailComposeViewControllerDelegate, SFSafariViewControllerDelegate {
    
    func reading(index: Int) {
        open()
    }
    func listening(index: Int) {
        guard let path = Bundle.main.path(forResource: "iphone", ofType: "mp3") else {return}
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
            if let frame = playerViewController.contentOverlayView?.bounds{
                let imageView = UIImageView(image: UIImage(named: "LidersBook"))
                imageView.frame = frame
                
                playerViewController.contentOverlayView?.addSubview(imageView)
            }
            
        }
    }
    func watch(index: Int) {
        let youTubeLink = "https://www.youtube.com/watch?v=fzjtvq-jC4E"
        if let url = URL(string: youTubeLink){
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
}

extension MainVC{
    func open() {
        let config = FolioReaderConfig()
        let bookPath = Bundle.main.path(forResource: "the_record", ofType: "epub")
        let folioReader = FolioReader()
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath!, andConfig: config)
    }
    
}
