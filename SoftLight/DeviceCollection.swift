//
//  DeviceHandler.swift
//  SoftLight
//
//  Created by Ben Groß on 11/18/21.
//

import Foundation
import CoreData

class DeviceCollection: NSObject, ObservableObject {
    @Published var deviceCollection: [Device] = []
    private let deviceCollectionController: NSFetchedResultsController<Device>

    init(managedObjectContext: NSManagedObjectContext) {
        deviceCollectionController = NSFetchedResultsController(fetchRequest: Device.deviceFetchRequest,
        managedObjectContext: managedObjectContext,
        sectionNameKeyPath: nil, cacheName: nil)

        super.init()

        deviceCollectionController.delegate = self

        do {
          try deviceCollectionController.performFetch()
            deviceCollection = deviceCollectionController.fetchedObjects ?? []
        } catch {
          print("failed to fetch items!")
        }
    }
    
    func addItem(context: NSManagedObjectContext, ip: String, friendlyName: String){
        let device = Device(context: context)
        device.friendlyName = friendlyName
        device.ip = ip
        deviceCollection.append(device)
        do {
            try deviceCollectionController.managedObjectContext.save()
        } catch{
            print("Whoops \(error.localizedDescription)")
        }
    }
    
    
    
}

extension DeviceCollection: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let devices = controller.fetchedObjects as? [Device]
      else { return }

    deviceCollection = devices
  }
}
