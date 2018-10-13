//
//  ToDoInfo.swift
//  SimpleJsonParsing
//
//  Created by Sujananth on 10/13/18.
//  Copyright © 2018 sujananth. All rights reserved.
//

import UIKit

class ToDoInfo {
    
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    init(userId: Int, id: Int, title: String, completed: Bool) {
        
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
    
}
