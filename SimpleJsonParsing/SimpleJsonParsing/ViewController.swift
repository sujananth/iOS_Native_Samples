//
//  ViewController.swift
//  SimpleJsonParsing
//
//  Created by Sujananth on 10/13/18.
//  Copyright © 2018 sujananth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let downloadURLString = "https://jsonplaceholder.typicode.com/todos"
    var downloadedToDoList: [ToDoInfo?] = []
    
    @IBOutlet weak var notesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func onTappingDownloadData(_ sender: Any) {
        
        guard let downloadURL = URL(string: self.downloadURLString) else {
            return
        }
        self.downloadJsonFrom(downloadURL)
    }
    
    //Following function return plain json and this is common for all cases
    func downloadJsonFrom(_ downloadURL: URL) {
    
        let jsonDownloadTask = URLSession.shared.dataTask(with: downloadURL) { (downloadedData, response, error) in
            
            guard let dataResponse = downloadedData, error == nil else {
                print(error?.localizedDescription ?? "Response error")
                return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                self.downcastJsonToRequiredType(jsonResponse)
            } catch {
                print(error.localizedDescription)
            }
        }
        jsonDownloadTask.resume()
    }
    
    //Following function is to downcast type of Any to [Any]
    func downcastJsonToRequiredType(_ json: Any) {
        
        //Folowing json cotains array of value hence downcating to array
        guard let toDoList = json as? [Any] else {
            return
        }
        //If Json starts with dictionary [key, value] then, json  as? [String: Any]
        self.createObjectsFrom(toDoList)
    }
    
    func createObjectsFrom(_ toDoList: [Any]) {
        
        for toDoData in toDoList {
            
            guard let toDo = toDoData as? Dictionary<String,Any> else  {
                return
            }
            
            let userId: Int  = toDo["userId"] as! Int
            let id: Int = toDo["id"] as! Int
            let title: String = toDo["title"] as! String
            let completed: Bool = toDo["completed"] as! Bool
            
            let toDoInfo = ToDoInfo(userId: userId, id: id, title: title, completed: completed)
            self.downloadedToDoList.append(toDoInfo)
        }
        DispatchQueue.main.async {
            self.notesTableView.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return downloadedToDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kTestCell", for: indexPath)
        let testDatInfo = downloadedToDoList[indexPath.row]
        cell.textLabel?.text = testDatInfo?.title
        return cell
    }
}

