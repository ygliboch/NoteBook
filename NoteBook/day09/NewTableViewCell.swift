//
//  NewTableViewCell.swift
//  day09
//
//  Created by Yaroslava HLIBOCHKO on 7/6/19.
//  Copyright © 2019 Yaroslava HLIBOCHKO. All rights reserved.
//

import UIKit
import yhliboch2019

class NewTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var modificationDateLabel: UILabel!
    var formatter = DateFormatter()
    
    var article: Entity? {
        didSet {
            titleLabel.text = article?.tille
            contentLabel.text = article?.content
            
            if let cDate = article?.creation as Date?, let uDate = article?.modification as Date? {
                creationDateLabel.text = NSLocalizedString("Create date", comment: "") + ": \(self.formatDate(date: cDate))"
                if cDate != uDate {
                    modificationDateLabel.isEnabled = true
                    modificationDateLabel.text = NSLocalizedString("Update date", comment: "") + ": \(self.formatDate(date: uDate))"
                }
                else {
                    modificationDateLabel.text = ""
                    modificationDateLabel.isEnabled = false
                }
            }
            else {
                creationDateLabel.text = ""
                creationDateLabel.isEnabled = false
                modificationDateLabel.text = ""
                modificationDateLabel.isEnabled = false
            }
            
            if let imageData = article?.image as Data?, let newImage = UIImage(data: imageData) {
//                heightConstraint.constant = 246
                myImage.image = newImage
            }
            else {
//                heightConstraint.constant = 0
                myImage.image = nil
                //                articleImageView.image = UIImage(named: "noImage")
            }
        }
    }
    
    func formatDate(date: Date) -> String {
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let formattedDate = formatter.string(from: date)
        
        return formattedDate
    }
}
