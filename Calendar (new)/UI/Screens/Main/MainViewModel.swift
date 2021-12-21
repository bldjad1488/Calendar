//
//  MainViewModel.swift
//  Calendar (new)
//
//  Created by Polina Prokopenko on 12/18/21.
//

import Foundation


class MainViewModel {
    
    let aliceCalendar: Calendar = [
        BookedTime(start: 11, end: 13),
        BookedTime(start: 15, end: 17),
        BookedTime(start: 18, end: 19)
    ]

    let bobCalendar: Calendar = [
        BookedTime(start: 10, end: 12),
        BookedTime(start: 18, end: 19),
        BookedTime(start: 15, end: 16)
    ]
    
    func calculateBookedTime(_ first: Calendar, _ second: Calendar) -> (first: [[Int]], second: [[Int]]) {
        var resultSet = [[Int]]()
        var resultSetTwo = [[Int]]()
        
        for item in first {
            resultSet.append(item.makeArray())
        }
        
        for item in second {
            resultSetTwo.append(item.makeArray())
        }
        
        return (resultSet, resultSetTwo)
    }
    
    func getFreeTimeForPersons(_ bookedTime: (first: [[Int]], second: [[Int]])) -> (first: [[Int]], second: [[Int]]) {
        let firstFreeTime  = getFreeTime(bookedTime.first)
        let secondFreeTime = getFreeTime(bookedTime.second)
        
        return (firstFreeTime, secondFreeTime)
    }
    
    
    func getFreeTime(_ bookedTime: [[Int]]) -> [[Int]] {
        let count = bookedTime.count
        let presortedBookedTime = bookedTime.sorted(by: { $0.first! < $1.first! })
        var sorted = [[Int]]()
        var freeTime = [[Int]]()
        
        // Remove unnecessary intervals from the array
        for i in 0..<count {
            if i < count - 1 {
                if presortedBookedTime[i].last != presortedBookedTime[i + 1].first {
                    sorted.append(presortedBookedTime[i])
                    sorted.append(presortedBookedTime[i + 1])
                }
            }
        }
        
        // Making intervals
        for i in 0..<count {
            if i <= count - 1 {
                
                // If interval is first
                if i == 0 {
                    if presortedBookedTime[i].first != 9 {
                        let start = 9
                        if let end = presortedBookedTime[i].first {
                            freeTime.append(Array(start...end))
                        }
                    }
                    
                    if presortedBookedTime.count >= 2 {
                        guard let start = presortedBookedTime[i].last else { return [] }
                        guard let end = presortedBookedTime[i + 1].first else { return [] }
                        
                        freeTime.append(Array(start...end))
                    }
                    
                // If interval is last
                } else if i == count - 1 {
                    if presortedBookedTime[i].last != 20 {
                        if let start = presortedBookedTime[i].last {
                            let end = 20
                            freeTime.append(Array(start...end))
                        }
                    }
                    
                // If interval in center
                } else {
                    guard let start = presortedBookedTime[i].last else { return [] }
                    guard let end   = presortedBookedTime[i + 1].first else { return [] }

                    freeTime.append(Array(start...end))

                    if i > 0 {
                        guard let start = presortedBookedTime[i - 1].last else { return [] }
                        guard let end = presortedBookedTime[i].first else { return [] }

                        freeTime.append(Array(start...end))
                    }
                }
            }
        }
        
        // Delete elements with count equal 1 or less
        var stepper = 0
        var count1 = freeTime.count - 1
        
        while stepper <= count1 {
            if freeTime[stepper].count < 2 || freeTime[stepper].count == 1{
                freeTime.remove(at: stepper)
                count1  -= 1
                stepper -= 1
            } else {
                stepper += 1
            }
        }
        
        return freeTime
    }
    
    func getBookedTimeForBoth(_ bookedTime: (first: [[Int]], second: [[Int]])) -> [[Int]] {
        let first  = bookedTime.first
        let second = bookedTime.second
    
        var array = Set(first).union(Set(second)).sorted(by: { $0.last! < $1.last! })
        
        var i = 0
        var arrayCount = array.count - 1
        
        while i < arrayCount {
            if i < array.count - 1 {
                if array[i].contains(array[i + 1].sorted().first!) || array[i].contains(array[i + 1].sorted()[1]) {
                    for item in array[i + 1] {
                        array[i].append(item)
                    }
                    
                    array[i] = array[i].sorted()
                    
                    array.remove(at: i + 1)
                    
                    arrayCount -= 1
                    i = 0
                } else {
                    i += 1
                }
            }
        }
        
        return Array(array).sorted(by: { $0.first! <= $1.first! })
    }
    
    func getFreeTimeForBoth(_ freeTime: [[Int]]) -> [[Int]] {
        let preparedFreeTime = getFreeTime(freeTime)
        var newFreeTime = [[Int]]()
        
        // Split all elements
        for item in preparedFreeTime {
            var start = 0
            var end   = 0
            
            if item.count > 2 {
                for i in item {
                    if i != item.last! {
                        start = i
                        end   = i + 1
                        
                        newFreeTime.append([start, end])
                    }
                }
            } else {
                newFreeTime.append(item)
            }
        }
        
        return newFreeTime
    }
    
}
