//
//  TimeSlotView.swift
//  Calendar (new)
//
//  Created by Polina Prokopenko on 12/19/21.
//

import Foundation
import UIKit


class TimeSlotView: UIView {
    
    enum TimeSlotType {
        case alice
        case bob
        case freeForPerson
        case freeForBoth
        case bookedForBoth
    }
    
    func addDashedBorder() {
        let color      = UIColor.systemGreen.cgColor
        let shapeLayer = CAShapeLayer()
        let frameSize  = frame.size
        let shapeRect  = CGRect(x: 0, y: 0, width: frameSize.width - 4, height: frameSize.height - 4)

        shapeLayer.bounds          = shapeRect
        shapeLayer.position        = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor       = UIColor.clear.cgColor
        shapeLayer.strokeColor     = color
        shapeLayer.lineWidth       = 2
        shapeLayer.lineJoin        = .round
        shapeLayer.lineDashPattern = [6,6]
        shapeLayer.path            = UIBezierPath(roundedRect: shapeRect, cornerRadius: 10).cgPath

        layer.addSublayer(shapeLayer)
    }
    
    init(type: TimeSlotType,  frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        
        switch type {
        case .alice:
            backgroundColor = .systemBlue
        case .bob:
            backgroundColor = .systemOrange
        case .freeForPerson:
            backgroundColor = .clear
            addDashedBorder()
        case .freeForBoth:
            backgroundColor = .systemGreen
        case .bookedForBoth:
            backgroundColor = .systemRed
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
