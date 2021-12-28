//
//  ProfileCell.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 18/08/21.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: "ProfileCell", bundle: nil)
    }
    static let identifier = "ProfileCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func updateCell(image:UIImage, label:String){
        img.image = image
        lbl.text = label
    }
    
}
