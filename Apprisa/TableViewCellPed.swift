//
//  TableViewCellPed.swift
//  Apprisa
//
//  Created by Sergio Guerrero Olvera on 22/04/21.
//

import UIKit

class TableViewCellPed: UITableViewCell
{
    @IBOutlet weak var lblPed: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
