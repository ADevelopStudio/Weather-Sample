//
//  TouchableTableViewCell.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 23/3/21.
//

import UIKit

class TouchableTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.isMultipleTouchEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1) {self.transform = CGAffineTransform(scaleX: 0.97, y:  0.97)}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1) {self.transform = CGAffineTransform(scaleX: 1, y:  1)}
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {self.transform = CGAffineTransform(scaleX: 1, y:  1)}
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected { UISelectionFeedbackGenerator().selectionChanged()}
    }
    
}
