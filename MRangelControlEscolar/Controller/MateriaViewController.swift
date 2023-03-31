//
//  MateriaViewController.swift
//  MRangelControlEscolar
//
//  Created by MacBookMBA5 on 28/02/23.
//

import UIKit

class MateriaViewController: UIViewController {
    
    @IBOutlet weak var NombreField: UITextField!
    @IBOutlet weak var CostoField: UITextField!
    @IBOutlet weak var BtnActualizar: UIButton!
    
    
    var materiaModel = Materia()
    var materiaViewModel = MateriaViewModel()
    var materia = Result<Materia>()
    var idMateria : Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        validar()
        // Do any additional setup after loading the view.
    }
    
    func validar () {
        if idMateria == nil {
            BtnActualizar.setTitle("Agregar", for: .normal)
        }else {
            BtnActualizar.setTitle("Actualizar", for: .normal)
            materiaViewModel.GetByIdMateria(idMateria: idMateria!, materia: { requestdata, error in
                if let requestdata1 = requestdata {
                    DispatchQueue.main.async { [self] in
                        self.materia = requestdata1
                        print(requestdata?.Object)
                        
                        if materia.Object != nil {
                            NombreField.text = materia.Object?.Nombre
                            CostoField.text = String(materia.Object!.Costo!)
                        }
                    }
                }
                if let error1 = error {
                    print(error1.localizedDescription)
                }
            })
        }
    }
    
    
    @IBAction func BtnAcciones(_ sender: Any) {
        if BtnActualizar.currentTitle == "Agregar" {
            guard let Nombre = NombreField.text, Nombre != "" else {
                NombreField.placeholder = "Ingresa el nombre"
                return
            }
            guard let Costo = CostoField.text, Costo != "" else {
                CostoField.placeholder = "Ingresa el costo"
                return
            }
            
            materiaModel = Materia(IdMateria: 0, Nombre: Nombre, Costo: Double(Costo))
            
            materiaViewModel.PostMateria(materia: materiaModel, result: { requestdata, error in
                
                if let postdata = requestdata {
                    DispatchQueue.main.async { [self] in
                        self.materia = postdata
                        print(self.materia)
                        
                        if materia.Correct == true{
                            let alert = UIAlertController(title: "Confirmación", message: "Materia agregada correctamente", preferredStyle: .alert)
                            //let ok = UIAlertAction(title: "OK", style: .default)
                            let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                                            { action in
                                
                                self.NombreField.text = ""
                                self.CostoField.text = ""
                                
                            })
                            //alert.addAction(ok)
                            alert.addAction(Aceptar)
                            self.present(alert, animated: false)
                            
                        }else{
                            
                            let alertError = UIAlertController(title: "Error", message: "La materia no se pudo agregar", preferredStyle: .alert)
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
        
        if BtnActualizar.currentTitle == "Actualizar" {
            
            guard let Nombre = NombreField.text, Nombre != "" else {
                NombreField.placeholder = "Ingresa el nombre"
                return
            }
            guard let Costo = CostoField.text, Costo != "" else {
                CostoField.placeholder = "Ingresa el costo"
                return
            }
            
            materiaModel = Materia(IdMateria: Int(idMateria!), Nombre: Nombre, Costo: Double(Costo))
            
            materiaViewModel.PostUpdateMateria(materia: materiaModel, result: { requestdata, error in
                
                if let postdata = requestdata {
                    DispatchQueue.main.async { [self] in
                        self.materia = postdata
                        print(self.materia)
                        
                        if materia.Correct == true{
                            let alert = UIAlertController(title: "Confirmación", message: "Materia actualizada correctamente", preferredStyle: .alert)
                            //let ok = UIAlertAction(title: "OK", style: .default)
                            let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                                            { action in
                                
                                self.NombreField.text = ""
                                self.CostoField.text = ""
                                
                            })
                            //alert.addAction(ok)
                            alert.addAction(Aceptar)
                            self.present(alert, animated: false)
                            
                        }else{
                            
                            let alertError = UIAlertController(title: "Error", message: "La materia no se pudo actualizar", preferredStyle: .alert)
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
    
    
        
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
