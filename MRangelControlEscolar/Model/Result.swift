//
//  Result.swift
//  MRangelControlEscolar
//
//  Created by MacBookMBA5 on 23/02/23.
//

import Foundation

struct Result <T : Codable> : Codable {
    var Correct : Bool?
    let ErrorMessage : String?
    let Object : T?
    let Objects : [T]?
    
    init(Correct: Bool? = nil, ErrorMessage: String?, Object: Codable?, Objects: [Codable]?) {
        self.Correct = Correct
        self.ErrorMessage = ErrorMessage
        self.Object = Object as! T
        self.Objects = Objects as! [T]
    }
    init(){
        self.Correct = false
        self.ErrorMessage = ""
        self.Object = nil
        self.Objects = nil
    }
}

struct Alumno : Codable {
    let IdAlumno : Int
    let Nombre : String?
    let ApellidoPaterno : String?
    let ApellidoMaterno : String?
    let FechaNacimiento : String?
    let Genero : String?
    let Telefono : String?
    
    init(IdAlumno : Int, Nombre: String, ApellidoPaterno: String, ApellidoMaterno: String, FechaNacimiento: String, Genero: String, Telefono: String) {
        self.IdAlumno = IdAlumno
        self.Nombre = Nombre
        self.ApellidoPaterno = ApellidoPaterno
        self.ApellidoMaterno = ApellidoMaterno
        self.FechaNacimiento = FechaNacimiento
        self.Genero = Genero
        self.Telefono = Telefono
    }
    init(){
        self.IdAlumno = 0
        self.Nombre = ""
        self.ApellidoPaterno = ""
        self.ApellidoMaterno = ""
        self.FechaNacimiento = ""
        self.Genero = ""
        self.Telefono = ""
    }
}

struct Materia : Codable {
    let IdMateria : Int
    let Nombre : String?
    let Costo : Double?
    
    init(IdMateria: Int, Nombre: String?, Costo: Double?) {
        
        self.IdMateria = IdMateria
        self.Nombre = Nombre
        self.Costo = Costo
    }
    init(){
        self.IdMateria = 0
        self.Nombre = ""
        self.Costo = 0
    }
}
