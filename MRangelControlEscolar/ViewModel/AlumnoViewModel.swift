//
//  AlumnoViewModel.swift
//  MRangelControlEscolar
//
//  Created by MacBookMBA5 on 23/02/23.
//

import Foundation
class AlumnoViewModel {
    
    var result = Result<Alumno>()
    
    func GetAlumnos(alumno : @escaping (Result<Alumno>?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "http://192.168.0.152/ControlEscolar/api/Alumno")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")
            guard let data = data else {
                return
                
            }
            self.result = try! decoder.decode(Result<Alumno>.self, from: data)
            alumno(self.result,nil)

            if let error = error{
                alumno(nil, error)
            }
            
        }.resume()
    }
    
    func Postalumno(alumno : Alumno ,result : @escaping (Result<Alumno>?, Error?) -> Void){
        do{
           let decoder = JSONDecoder()
           let baseURL =  "http://192.168.0.152/ControlEscolar/api/Alumno"
            let url = URL(string: baseURL)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try! JSONEncoder().encode(alumno)
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest){ data, response, error in
                guard let data = data else {
                    return
                }
               // print("DataSession \(String(describing: data))")
                //print(data)
                let json = try? JSONSerialization.jsonObject(with: data)
                self.result = try! decoder.decode(Result<Alumno>.self, from: data)
                result(self.result,nil)
            }.resume()
        }
    }
    
    func GetByIdAlumno(idAlumno: Int, alumno: @escaping(Result<Alumno>?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "http://192.168.0.152/ControlEscolar/api/Alumno/\(idAlumno)")
        urlSession.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            self.result = try! decoder.decode(Result<Alumno>.self, from: data)
            alumno(self.result, nil)
            
            if let error = error {
                alumno(nil, error)
            }
        }.resume()
    }
    
    func PostUpdateAlumno(alumno : Alumno ,result : @escaping (Result<Alumno>?, Error?) -> Void){
        do{
           let decoder = JSONDecoder()
            let baseURL =  "http://192.168.0.152/ControlEscolar/api/Alumno/\(alumno.IdAlumno)"
            let url = URL(string: baseURL)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try! JSONEncoder().encode(alumno)
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest){ data, response, error in
                guard let data = data else {
                    return
                }
               // print("DataSession \(String(describing: data))")
                //print(data)
                let json = try? JSONSerialization.jsonObject(with: data)
                self.result = try! decoder.decode(Result<Alumno>.self, from: data)
                result(self.result,nil)
            }.resume()
        }
    }
    
    
    
    
}
