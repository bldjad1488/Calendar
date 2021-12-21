//
//  Label.swift
//  Calendar (new)
//
//  Created by Polina Prokopenko on 12/19/21.
//

import UIKit


class Label: UILabel {
    
    init(_ text: String, color: UIColor, frame: CGRect) {
        super.init(frame: frame)
        
        self.text = text
        textAlignment = .center
        textColor = color
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
