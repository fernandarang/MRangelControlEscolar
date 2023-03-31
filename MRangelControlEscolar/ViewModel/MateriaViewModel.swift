//
//  MateriaViewModel.swift
//  MRangelControlEscolar
//
//  Created by MacBookMBA5 on 28/02/23.
//

import Foundation
class MateriaViewModel {
    
    var result = Result<Materia>()
    
    func GetMateria(materia : @escaping (Result<Materia>?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "http://192.168.0.152/ControlEscolar/api/Materia")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")
            guard let data = data else {
                //print("GetToken")
                // print(data)
                return
                
            }
            self.result = try! decoder.decode(Result<Materia>.self, from: data)
            materia(self.result,nil)
            
            if let error = error{
                materia(nil, error)
            }
            
        }.resume()
    }
    
    func PostMateria(materia : Materia ,result : @escaping (Result<Materia>?, Error?) -> Void){
        do{
            let decoder = JSONDecoder()
            let baseURL =  "http://192.168.0.152/ControlEscolar/api/Materia"
            let url = URL(string: baseURL)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try! JSONEncoder().encode(materia)
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest){ data, response, error in
                guard let data = data else {
                    return
                }
                // print("DataSession \(String(describing: data))")
                //print(data)
                let json = try? JSONSerialization.jsonObject(with: data)
                self.result = try! decoder.decode(Result<Materia>.self, from: data)
                result(self.result,nil)
            }.resume()
        }
    }
    
    func GetByIdMateria(idMateria: Int, materia: @escaping(Result<Materia>?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "http://192.168.0.152/ControlEscolar/api/Materia/\(idMateria)")
        urlSession.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            self.result = try! decoder.decode(Result<Materia>.self, from: data)
            materia(self.result, nil)
            
            if let error = error {
                materia(nil, error)
            }
        }.resume()
    }
    
    func PostUpdateMateria(materia : Materia ,result : @escaping (Result<Materia>?, Error?) -> Void){
        do{
           let decoder = JSONDecoder()
            let baseURL =  "http://192.168.0.152/ControlEscolar/api/Materia/\(materia.IdMateria)"
            let url = URL(string: baseURL)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try! JSONEncoder().encode(materia)
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest){ data, response, error in
                guard let data = data else {
                    return
                }
               // print("DataSession \(String(describing: data))")
                //print(data)
                let json = try? JSONSerialization.jsonObject(with: data)
                self.result = try! decoder.decode(Result<Materia>.self, from: data)
                result(self.result,nil)
            }.resume()
        }
    }
    
}
