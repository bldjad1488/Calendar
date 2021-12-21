//
//  CalendarModel.swift
//  Calendar (new)
//
//  Created by Polina Prokopenko on 12/18/21.
//

import UIKit


typealias Calendar = [BookedTime]

struct BookedTime {
    
    let start: Int
    let end: Int
    
    func makeArray() -> [Int] {
        return Set(start...end).sorted { $0 < $1 }
    }
    
}
