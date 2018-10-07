//
//  ViewController.swift
//  CoreData_Add_Update_Delete
//
//  Created by Sujananth on 10/7/18.
//  Copyright © 2018 sujananth. All rights reserved.
//

import UIKit
import CoreData

private typealias TableViewDataSource = ViewController
private typealias TableViewDelegate = ViewController
private typealias FetchedResultControllerDelegate = ViewController
private typealias HelperMethods = ViewController

class ViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext? = nil
    @IBOutlet weak var dateDescriptionTableView: UITableView!
    
    //Computed Prperty will initialize fechedResultControler only when its accessed firstime.
    var _fetchedResultsController: NSFetchedResultsController<DateDescription>? = nil
    var fetchedResultsController: NSFetchedResultsController<DateDescription> {
        
        if(_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<DateDescription> = DateDescription.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "dateInfo", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        self._fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        self._fetchedResultsController?.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved Error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    @IBAction func OnTappingAdd(_ sender: Any) {
        
        self.addToManagedObjectContext()
    }
}

extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "kDateDescriptionCellID", for: indexPath)
        let dateDescriptionEntity = self.fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = dateDescriptionEntity.dateInfo
        cell.detailTextLabel?.text = dateDescriptionEntity.additionalInfo
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == UITableViewCell.EditingStyle.delete) {
            self.managedObjectContext?.delete(self.fetchedResultsController.object(at: indexPath))
        }
    }
}

extension TableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath), let dateText = cell.textLabel?.text  else {
            return
        }
        self.updateManagedObjectContextOf(date: dateText)
    }
}

extension FetchedResultControllerDelegate: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        self.dateDescriptionTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        //IndexPath will be nill on addition or insertion in ManagedObjectContext: https://developer.apple.com/documentation/coredata/nsfetchedresultscontrollerdelegate/1622296-controller
        //So while insertion we get indexPath for the object in fetchedResultsController
        if let modifiedIndexPath = indexPath ?? self.fetchedResultsController.indexPath(forObject: anObject as! DateDescription)  {
            
            self.modifyListViewForChangeOf(type: type, in: [modifiedIndexPath])
        } else {
            
            print("Error: index path for modified data is nill")
            return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        self.dateDescriptionTableView.endUpdates()
    }
    
}

extension HelperMethods {
    
    func modifyListViewForChangeOf(type: NSFetchedResultsChangeType, in indexPathSet:[IndexPath]) {
        
        switch type {
            
        case .delete:
            self.dateDescriptionTableView.deleteRows(at: indexPathSet, with: UITableView.RowAnimation.fade)
            
        case .insert:
            self.dateDescriptionTableView.insertRows(at: indexPathSet, with: UITableView.RowAnimation.fade)
            
        case .move:
            //While move we need to reload tableView.
            //We must animate between beginUpdate and endUpdate while reloading: https://developer.apple.com/documentation/uikit/uitableview/1614908-beginupdates
            UIView.transition(with: self.dateDescriptionTableView, duration: 1.0, options: .curveLinear, animations: {self.dateDescriptionTableView.reloadData()}, completion: nil)
            
        case .update:
            self.dateDescriptionTableView.reloadRows(at: indexPathSet, with: UITableView.RowAnimation.fade)
        }
    }

    func updateManagedObjectContextOf(date: String) {
        
        let fetchRequest: NSFetchRequest<DateDescription> = DateDescription.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "dateInfo = '\(date)'")
        do {
            
            guard let _context = self.managedObjectContext else { return }
            let test = try _context.fetch(fetchRequest)
            if test.count == 1 {
                
                let objectUpdate = test[0] as NSManagedObject
                objectUpdate.setValue(self.getDateTimeWithNanoSecond(), forKey: "dateInfo")
                objectUpdate.setValue("Tap a Cell to update Date Time", forKey: "additionalInfo")
            }
        } catch {
            
            print(error)
        }
    }
    
    func addToManagedObjectContext() {
        
        guard let _context = self.managedObjectContext else { return }
        let object = NSEntityDescription.insertNewObject(forEntityName: "DateDescription", into: _context) as! DateDescription
        object.dateInfo = self.getDateTimeWithNanoSecond()
        object.additionalInfo = "Slide Left to delete Cells"
    }
    
    func getDateTimeWithNanoSecond() -> String {
        
        let d = Date()
        let df = DateFormatter()
        df.dateFormat = "y-MM-dd H:m:ss.SSSS"
        return df.string(from: d)
    }
}
