//
//  Device+CoreDataProperties.swift
//  SoftLight
//
//  Created by Ben Groß on 11/17/21.
//

import Foundation
import CoreData

extension Device {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var friendlyName: String
    @NSManaged public var ip: String
    

}

extension Device : Identifiable {

}

extension Device {
  static var deviceFetchRequest: NSFetchRequest<Device> {
    let request: NSFetchRequest<Device> = Device.createFetchRequest()
//    request.predicate = NSPredicate(format: "dueDate < %@", Date.nextWeek() as CVarArg)
    request.sortDescriptors = [NSSortDescriptor(key: "friendlyName", ascending: true)]

    return request
  }
}
