//
//  MainView.swift
//  Calendar (new)
//
//  Created by Polina Prokopenko on 12/18/21.
//

import UIKit


class MainView: UIViewController {
    
    let viewModel = MainViewModel()
    
    lazy var scrollView: UIScrollView = {
        let s = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        s.showsHorizontalScrollIndicator = false
        
        return s
    }()
    
    lazy var calendarView = CalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        prepareCalendarView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendarView.center.y = view.center.y
        scrollView.frame.size.width = view.frame.width
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
}


// MARK: Prepare calendar view
extension MainView {
    
    func prepareCalendarView() {
        let bookedTime = viewModel.calculateBookedTime(viewModel.aliceCalendar, viewModel.bobCalendar)
        let freeTime   = viewModel.getFreeTimeForPersons(bookedTime)
        let bookedTimeForBoth = viewModel.getBookedTimeForBoth(bookedTime)
        let trulyFreeTimeForBoth = viewModel.getFreeTimeForBoth(bookedTimeForBoth)
        
        calendarView.render(
            firstBookedTime: bookedTime.first,
            secondBookedTime: bookedTime.second,
            firstFreeTime: freeTime.first,
            secondFreeTime: freeTime.second,
            bookedForBoth: bookedTimeForBoth,
            freeForBoth: trulyFreeTimeForBoth
        )
    }
    
}


// MARK: Setup view
extension MainView {
    
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(calendarView)
        
        calendarView.center.y  = view.center.y
        scrollView.contentSize = CGSize(width: calendarView.frame.width, height: view.frame.height)
    }
    
}
