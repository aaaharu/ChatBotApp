//
//  ChatCell.swift
//  ChatBotApp
//
//  Created by 김은지 on 2023/06/09.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatTextView: UITextView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chatTextView.setContentOffset(CGPoint.zero, animated: false)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
