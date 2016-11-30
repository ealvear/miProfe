//
//  gestorUniversidad.swift
//  miProfe
//
//  Created by capitan on 28/11/16.
//  Copyright © 2016 capitan. All rights reserved.
//
import Foundation

class GestorUniversidades {
    
    var universidades:[Universidad] = [Universidad]()
    var callback:Any?
    
    init() {
        self.callback = nil
    }
    
    func processUniversidades(data:Data?){
        //primera forma
        var universidad:Universidad?
        do{
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String: Any]]
            
            
            let id = String(json[0]["idUniversidad"] as! Int)
            let nombre = json[0]["nombreUniversidad"] as! String
            let descripcion = json[0]["descripcionUniversidad"] as! String
            let foto = json[0]["fotoUniversidad"] as! String
            universidad = Universidad(id: id, nombre: nombre, descripcion: descripcion, foto: foto)
            if let uni = universidad {
                print("id: "+uni.id)
                print("nombre: "+uni.nombre)
                print("descripcion: "+uni.descripcion)
                if (uni.foto != nil) {
                    print("foto: "+uni.foto!)
                }
                let callb = self.callback as! (_ universidades:[Universidad])->Void
                callb([uni])
            }
        }catch{}
        
        /*
         // segunda forma
         do{
         let json:[NSDictionary] = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [NSDictionary]
         let query:NSDictionary = json[0]
         //resultado = json[0].object(forKey: "nombreUniversidad") as? String
         resultado = query.object(forKey: "nombreUniversidad") as? String
         
         }catch{}
         
         print(resultado ?? "cagada")
         */
        
    }
    
    func obtenruniversidades(callback:@escaping (_ universidades:[Universidad])->Void){
        
        let client:HttpClient = HttpClient()
        
        self.callback = callback
        client.get(url: "http://192.168.0.90:8081/universidad", callback: processUniversidades )
        
        
    }
    
    
}
