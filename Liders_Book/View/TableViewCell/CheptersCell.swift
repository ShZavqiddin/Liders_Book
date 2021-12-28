//
//  CheptersCell.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 18/08/21.
//

import UIKit

class CheptersCell: UITableViewCell {

    static func nib() -> UINib{
        return UINib(nibName: "CheptersCell", bundle: nil)
    }
    static let identifier = "CheptersCell"
    
    @IBOutlet weak var numberImg: UIImageView!
    @IBOutlet weak var sectionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(section:String, number:UIImage){
        sectionLbl.text = section
        numberImg.image = number
    }

}
