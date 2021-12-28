//
//  CollapsCell.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 19/08/21.
//

import UIKit

protocol CollapsCellDelegate {
    func reading(index: Int)
    func listening(index: Int)
    func watch(index: Int)
}

class CollapsCell: UITableViewCell {

    static func nib() -> UINib{
        return UINib(nibName: "CollapsCell", bundle: nil)
    }
    static let identifier = "CollapsCell"
    
    @IBOutlet var btns: [UIButton]!{
        didSet{
            for btn in btns{
                btn.layer.cornerRadius = btn.frame.height/6
            }
        }
    }
    
    var delegate : CollapsCellDelegate?
    var index:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func reading(_ sender: Any) {
        delegate?.reading(index: index!.row)
    }
    
    @IBAction func listening(_ sender: Any) {
        delegate?.listening(index: index!.row)
    }
    
    @IBAction func watch(_ sender: Any) {
        delegate?.watch(index: index!.row)
    }
    
}
