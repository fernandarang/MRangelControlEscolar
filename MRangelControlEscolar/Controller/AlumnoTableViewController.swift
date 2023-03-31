//
//  TableViewController.swift
//  MRangelControlEscolar
//
//  Created by MacBookMBA5 on 23/02/23.
//

import UIKit
import SwipeCellKit

class AlumnoTableViewController: UITableViewController {
    
    var alumnoViewModel = AlumnoViewModel()
    var alumno = Result<Alumno>()
    var alumnos = [Alumno]()
    var idAlumno : Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "AlumnoTableViewCell", bundle: nil), forCellReuseIdentifier: "AlumnoCell")
        GetAlumno()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetAlumno()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func GetAlumno () {
        alumnoViewModel.GetAlumnos(alumno: {requestdata, error in
            if let requestdata1 = requestdata {
                DispatchQueue.main.async {
                    self.alumnos = requestdata1.Objects as! [Alumno]
                    print(requestdata?.Objects)
                    self.tableView.reloadData()
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
        })
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return alumnos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlumnoCell", for: indexPath) as! AlumnoTableViewCell

        cell.IdLbl.text = String(alumnos[indexPath.row].IdAlumno)
        cell.NombreLbl.text = alumnos[indexPath.row].Nombre
        cell.ApellidoLbl.text = alumnos[indexPath.row].ApellidoPaterno
        cell.ApellidoMLbl.text = alumnos[indexPath.row].ApellidoMaterno
        cell.FechaNacimientoLbl.text = alumnos[indexPath.row].FechaNacimiento
        cell.GeneroLbl.text = alumnos[indexPath.row].Genero
        cell.TelefonoLbl.text = alumnos[indexPath.row].Telefono
        
        cell.delegate = self
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AlumnoTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right {
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                self.idAlumno = self.alumnos[indexPath.row].IdAlumno
                //let result = self.productoViewModel.Delete(IdDelete: self.idProducto!)
                //self.GetAlumnos()
            }
            
            deleteAction.image = UIImage(systemName: "trash")
            
            return [deleteAction]
        }else{
            
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.idAlumno = self.alumnos[indexPath.row].IdAlumno
                self.performSegue(withIdentifier: "UpdateSegue", sender: self)
            }
            updateAction.image = UIImage (systemName: "highlighter")
            updateAction.backgroundColor = .blue
            return [updateAction]
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "UpdateSegue"{
                let alumnoController = segue.destination as! ViewController
                alumnoController.idAlumno = self.idAlumno
                print("recupero id")
            }
        }
    
}

