//
//  HighlightsCell.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 23/08/21.
//

import UIKit

class HighlightsCell: UITableViewCell {

    static func nib() -> UINib{
        return UINib(nibName: "HighlightsCell", bundle: nil)
    }
    static let identifier = "HighlightsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
