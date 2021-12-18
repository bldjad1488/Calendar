//
//  MainView.swift
//  Calendar (new)
//
//  Created by Polina Prokopenko on 12/18/21.
//

import UIKit


class MainView: UIViewController {
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        
        viewModel.value = "Hello"
        
        print(viewModel.value)
    }
    
}
