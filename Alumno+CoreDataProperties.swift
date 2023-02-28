//
//  Alumno+CoreDataProperties.swift
//  valentin_fernandez_fernandez_proyectoSwift
//
//  Created by monterrey on 26/2/23.
//
//

import Foundation
import CoreData


extension Alumno {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alumno> {
        return NSFetchRequest<Alumno>(entityName: "Alumno")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var apellidos: String?
    @NSManaged public var mates: Float
    @NSManaged public var lengua: Float
    @NSManaged public var historia: Float
}

extension Alumno : Identifiable {

}
