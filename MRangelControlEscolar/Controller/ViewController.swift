//
//  ViewController.swift
//  MRangelControlEscolar
//
//  Created by MacBookMBA5 on 22/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nombreLbl: UITextField!
    @IBOutlet weak var apellidoPaternoLbl: UITextField!
    @IBOutlet weak var apellidoMaternoLbl: UITextField!
    @IBOutlet weak var generoLbl: UITextField!
    @IBOutlet weak var fechaNacimientoLbl: UITextField!
    @IBOutlet weak var telefonoLbl: UITextField!
    @IBOutlet weak var AccionesBtn: UIButton!
    
    
    var alumnoModel = Alumno()
    var alumnoViewModel = AlumnoViewModel()
    var alumno = Result<Alumno>()
    var idAlumno : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        validar()
    }
    
    func validar () {
        if idAlumno == nil {
            AccionesBtn.setTitle("Agregar", for: .normal)
        }else {
            AccionesBtn.setTitle("Actualizar", for: .normal)
            alumnoViewModel.GetByIdAlumno(idAlumno: idAlumno!, alumno: { requestdata, error in
                if let requestdata1 = requestdata {
                    DispatchQueue.main.async { [self] in
                        self.alumno = requestdata1
                        print(requestdata?.Object)
                        
                        if alumno.Object != nil{
                           //let result = alumno.Object as! Alumno
                            nombreLbl.text = alumno.Object?.Nombre
                            apellidoPaternoLbl.text = alumno.Object?.ApellidoPaterno
                            apellidoMaternoLbl.text = alumno.Object?.ApellidoMaterno
                            fechaNacimientoLbl.text = alumno.Object?.FechaNacimiento
                            generoLbl.text = alumno.Object?.Genero
                            telefonoLbl.text = alumno.Object?.Telefono
                        }
                    }
                }
                if let error1 = error {
                    print(error1.localizedDescription)
                }
            })
            
        }
    }
    
    
    @IBAction func AccionesBtn(_ sender: UIButton) {
        
        if AccionesBtn.currentTitle == "Agregar" {
            guard let Nombre = nombreLbl.text, Nombre != "" else {
                nombreLbl.placeholder = "Ingresa el UserName"
                return
            }
            guard let ApellidoPaterno = apellidoPaternoLbl.text, ApellidoPaterno != "" else {
                apellidoPaternoLbl.placeholder = "Ingresa el apellido paterno"
                return
            }
            guard let ApellidoMaterno = apellidoMaternoLbl.text, ApellidoMaterno != "" else {
                apellidoMaternoLbl.placeholder = "Ingresa el apellido materno"
                return
            }
            guard let Telefono = telefonoLbl.text, Telefono != "" else {
                telefonoLbl.placeholder = "Ingresa el telefono"
                return
            }
            guard let Genero = generoLbl.text, Genero != "" else {
                telefonoLbl.placeholder = "Ingresa el genero"
                return
            }
            guard let Fecha = fechaNacimientoLbl.text, Fecha != "" else {
                fechaNacimientoLbl.placeholder = "Ingresa la fecha"
                return
            }
            
            alumnoModel = Alumno(IdAlumno : 0, Nombre: Nombre, ApellidoPaterno: ApellidoPaterno, ApellidoMaterno: ApellidoMaterno, FechaNacimiento: Fecha, Genero: Genero, Telefono: Telefono)
            
            alumnoViewModel.Postalumno(alumno: alumnoModel, result: { requestdata, error in
                
                if let postdata = requestdata {
                    DispatchQueue.main.async { [self] in
                        self.alumno = postdata
                        print(self.alumno)
                        
                        if alumno.Correct == true {
                            let alert = UIAlertController(title: "Confirmación", message: "Alumno agregado correctamente", preferredStyle: .alert)
                            //let ok = UIAlertAction(title: "OK", style: .default)
                            let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                                            { action in
                                
                                self.nombreLbl.text = ""
                                self.apellidoPaternoLbl.text = ""
                                self.apellidoMaternoLbl.text = ""
                                self.fechaNacimientoLbl.text = ""
                                self.generoLbl.text = ""
                                self.telefonoLbl.text = ""
                                
                            })
                            //alert.addAction(ok)
                            alert.addAction(Aceptar)
                            self.present(alert, animated: false)
                            
                        }else{
                            
                            let alertError = UIAlertController(title: "Error", message: "El alumno no se pudo agregar", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "OK", style: .default)
                            alertError.addAction(ok)
                            self.present(alertError, animated: false)
                        }
                        
                    }
                }
                if let error1 = error{
                    print(error1.localizedDescription)
                }
                
            })
            
            
        }
        if AccionesBtn.currentTitle == "Actualizar" {
            
                guard let Nombre = nombreLbl.text, Nombre != "" else {
                    nombreLbl.placeholder = "Ingresa el UserName"
                    return
                }
                guard let ApellidoPaterno = apellidoPaternoLbl.text, ApellidoPaterno != "" else {
                    apellidoPaternoLbl.placeholder = "Ingresa el apellido paterno"
                    return
                }
                guard let ApellidoMaterno = apellidoMaternoLbl.text, ApellidoMaterno != "" else {
                    apellidoMaternoLbl.placeholder = "Ingresa el apellido materno"
                    return
                }
                guard let Telefono = telefonoLbl.text, Telefono != "" else {
                    telefonoLbl.placeholder = "Ingresa el telefono"
                    return
                }
                guard let Genero = generoLbl.text, Genero != "" else {
                    telefonoLbl.placeholder = "Ingresa el genero"
                    return
                }
                guard let Fecha = fechaNacimientoLbl.text, Fecha != "" else {
                    fechaNacimientoLbl.placeholder = "Ingresa la fecha"
                    return
                }
            
            alumnoModel = Alumno(IdAlumno : Int(idAlumno!), Nombre: Nombre, ApellidoPaterno: ApellidoPaterno, ApellidoMaterno: ApellidoMaterno, FechaNacimiento: Fecha, Genero: Genero, Telefono: Telefono)
            
            alumnoViewModel.PostUpdateAlumno(alumno: alumnoModel, result: { requestdata, error in
                
                if let postdata = requestdata {
                    DispatchQueue.main.async { [self] in
                        self.alumno = postdata
                        print(self.alumno)
                        
                        if alumno.Correct == true{
                            let alert = UIAlertController(title: "Confirmación", message: "Alumno actualizado correctamente", preferredStyle: .alert)
                            //let ok = UIAlertAction(title: "OK", style: .default)
                            let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                                            { action in
                                
                                self.nombreLbl.text = ""
                                self.apellidoPaternoLbl.text = ""
                                self.apellidoMaternoLbl.text = ""
                                self.fechaNacimientoLbl.text = ""
                                self.generoLbl.text = ""
                                self.telefonoLbl.text = ""
                                
                            })
                            //alert.addAction(ok)
                            alert.addAction(Aceptar)
                            self.present(alert, animated: false)
                            
                        }else{
                            
                            let alertError = UIAlertController(title: "Error", message: "El alumno no se pudo actualizar", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "OK", style: .default)
                            alertError.addAction(ok)
                            self.present(alertError, animated: false)
                        }
                    }
                }
                if let error1 = error{
                    print(error1.localizedDescription)
                }
            })
        }
    }
    
    }
    

    
        
    
    
