//
//  CalendarView.swift
//  Calendar (new)
//
//  Created by Polina Prokopenko on 12/19/21.
//

import Foundation
import UIKit


class CalendarView: UIView {
    
    // MARK: Values
    // Need for positioning background lines and labels
    var marginFromLeading = 150
    var spaceBetweenLines = 80
    var spacingBetweenSlots = 5
    
    override func draw(_ rect: CGRect) {
        drawLines()
    }
    
    init() {
        let height = 275
        let width = marginFromLeading + (spaceBetweenLines * 12) + 20
        
        super.init(frame: CGRect(x: 0, y: 50, width: width, height: height))
        
        backgroundColor = .white
        
        addHoursLabels()
        addNameLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: Render time slots from data
extension CalendarView {
    
    func render(
        firstBookedTime: [[Int]],
        secondBookedTime: [[Int]],
        firstFreeTime: [[Int]],
        secondFreeTime: [[Int]],
        bookedForBoth: [[Int]],
        freeForBoth: [[Int]]) {
        
            for item in firstBookedTime {
                if let start = item.first, let end = item.last {
                    drawTimeSlot(position: 0, start: start, end: end, type: .alice)
                }
            }
            
            for item in secondBookedTime {
                if let start = item.first, let end = item.last {
                    drawTimeSlot(position: 1, start: start, end: end, type: .bob)
                }
            }
            
            for item in firstFreeTime {
                if let start = item.first, let end = item.last {
                    drawTimeSlot(position: 0, start: start, end: end, type: .freeForPerson)
                }
            }
            
            for item in secondFreeTime {
                if let start = item.first, let end = item.last {
                    drawTimeSlot(position: 1, start: start, end: end, type: .freeForPerson)
                }
            }
            
            for item in bookedForBoth {
                if let start = item.first, let end = item.last {
                    drawTimeSlot(position: 2, start: start, end: end, type: .bookedForBoth)
                }
            }
            
            for item in freeForBoth {
                if let start = item.first, let end = item.last {
                    drawTimeSlot(position: 2, start: start, end: end, type: .freeForBoth)
                }
            }
    }
    
    func renderExample() {
        for item in MainViewModel().aliceCalendar {
            drawTimeSlot(position: 0, start: item.start, end: item.end, type: .alice)
        }
        
        for item in MainViewModel().bobCalendar {
            drawTimeSlot(position: 1, start: item.start, end: item.end, type: .bob)
        }
        
        drawTimeSlot(position: 0, start: 13, end: 15, type: .freeForPerson)
        drawTimeSlot(position: 0, start: 17, end: 20, type: .freeForPerson)
        
        drawTimeSlot(position: 1, start: 12, end: 15, type: .freeForPerson)
        drawTimeSlot(position: 1, start: 16, end: 18, type: .freeForPerson)
        drawTimeSlot(position: 1, start: 19, end: 20, type: .freeForPerson)
        
        drawTimeSlot(position: 2, start: 9, end: 13, type: .bookedForBoth)
        drawTimeSlot(position: 2, start: 13, end: 14, type: .freeForBoth)
        drawTimeSlot(position: 2, start: 14, end: 15, type: .freeForBoth)
        drawTimeSlot(position: 2, start: 15, end: 17, type: .bookedForBoth)
        drawTimeSlot(position: 2, start: 17, end: 18, type: .freeForBoth)
        drawTimeSlot(position: 2, start: 18, end: 19, type: .bookedForBoth)
        drawTimeSlot(position: 2, start: 19, end: 20, type: .freeForBoth)
    }
    
}


// MARK: Draw time slots
extension CalendarView {
    
    private func drawTimeSlot(position: Int, start: Int, end: Int, type: TimeSlotView.TimeSlotType) {
        let yOffset: Int
        guard let startEnd = calculateStartAndEnd(start, end) else { return }
        
        switch position {
        case 0:
            yOffset = 80 - 25
        case 1:
            yOffset = 150 - 25
        case 2:
            yOffset = 220 - 25
        default:
            yOffset = 0
        }
        
        addSubview(TimeSlotView(
            type: type,
            frame: CGRect(x: startEnd.0, y: yOffset, width: startEnd.1 - startEnd.0, height: 50)
        ))
    }
    
    private func calculateStartAndEnd(_ start: Int, _ end: Int) -> (Int, Int)? {
        let s: Int
        let e: Int
        
        let timeArray = Array(9...20)
        
        guard let sIndex = timeArray.firstIndex(of: start) else { return nil }
        guard let eIndex = timeArray.firstIndex(of: end) else { return nil }
        
        func checkIndex(index: Int) -> Int {
            if index == 0 {
                return marginFromLeading
            } else {
                return (index) * spaceBetweenLines + marginFromLeading
            }
        }
        
        s = checkIndex(index: sIndex) + spacingBetweenSlots / 2
        e = checkIndex(index: eIndex) - spacingBetweenSlots / 2
        
        
        return (s, e)
    }
    
}


// MARK: Draw name labels
extension CalendarView {
    
    private func addNameLabels() {
        let aliceLabel = Label(
            "Alice",
            color: .systemBlue,
            frame: CGRect(x: 0, y: 80 - 25, width: marginFromLeading, height: 50)
        )
        let bobLabel = Label(
            "Bob",
            color: .systemOrange,
            frame: CGRect(x: 0, y: 150 - 25, width: marginFromLeading, height: 50)
        )
        let crossingLabel = Label(
            "Crossing the schedule",
            color: UIColor(named: "ColorGray")!,
            frame: CGRect(x: 0, y: 220 - 25, width: marginFromLeading, height: 50)
        )
        
        addSubview(aliceLabel)
        addSubview(bobLabel)
        addSubview(crossingLabel)
    }
    
}


// MARK: Draw backgroud
extension CalendarView {
    
    private func drawLines() {
        var num = marginFromLeading
        
        for i in 0..<12 {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: num, y: 40))
            path.addLine(to: CGPoint(x: num, y: 235 + 25))
            path.close()
            
            path.lineWidth = 2
            path.lineJoinStyle = .round
    
            UIColor(named: "ColorGray")?.setStroke()
            path.stroke()
            
            num += spaceBetweenLines
        }
    }
    
    private func addHoursLabels() {
        var num = marginFromLeading
        
        for i in 9..<21 {
            let textForLabel: String
            if i < 10 {
                textForLabel = "0\(i)"
            } else {
                textForLabel = "\(i)"
            }
            
            let label = UILabel(frame: CGRect(x: num - 15, y: 10, width: 30, height: 20))
            label.textColor = UIColor(named: "ColorGray")!
            label.text = textForLabel
            label.textAlignment = .center
            
            addSubview(label)
            
            num += spaceBetweenLines
        }
    }
    
}
