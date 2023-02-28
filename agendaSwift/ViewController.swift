//
//  ViewController.swift
//  valentin_fernandez_fernandez_proyectoSwift
//
//  Created by monterrey on 17/2/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
   

    @IBOutlet weak var txtusuario: UITextField!
    
    @IBOutlet weak var txtpassword: UITextField!
    
    @IBOutlet weak var txfintronom: UITextField!
    
    @IBOutlet weak var txfIntroAPell: UITextField!
    
    @IBOutlet weak var txfIntroMAtes: UITextField!
    
    @IBOutlet weak var txfIntroLengua: UITextField!
    
    @IBOutlet weak var txfIntroHisto: UITextField!
    @IBOutlet weak var txfIntroBorrar: UITextField!
    @IBOutlet weak var tbListar: UITableView!
    var alumno: [NSManagedObject] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alumno.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
         let alum = alumno[indexPath.row]
        //celda.imageView.image = alumno.
         celda.textLabel?.text = alum.value(forKey: "nombre") as? String
        return celda
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Alumno")
        
        do{
            alumno = try managedContext.fetch(fetchRequest)
            tbListar?.reloadData()
        }catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    
    @IBAction func btnAcceder(_ sender: UIButton) {
        
        let user = txtusuario.text!
        let pass = txtpassword.text!
        let vc = UINavigationController()
        
        if(user == "usuario" && pass == "password"){
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let MensAlerta = UIAlertController(title: "ERROR", message: "Usuario o Contraseña Erronea", preferredStyle: .alert)
            MensAlerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(MensAlerta, animated: true,completion: nil)
            
        }
    }
    
    
    @IBAction func btnIntoducir(_ sender: Any) {
        
        if(txfintronom.text!.isEmpty || txfIntroAPell.text!.isEmpty || txfIntroMAtes.text!.isEmpty || txfIntroLengua.text!.isEmpty || txfIntroHisto.text!.isEmpty){
            
            let Mensaje = UIAlertController(title: "Mensaje", message: "Debe introducir todos los datos", preferredStyle: .alert)
            Mensaje.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler:  nil))
            self.present(Mensaje, animated: true, completion: nil)
            
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context = appDelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Alumno", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(txfintronom.text, forKey: "nombre")
            newUser.setValue(txfIntroAPell.text, forKey: "apellidos")
            newUser.setValue(Float(txfIntroMAtes.text!), forKey: "mates")
            newUser.setValue(Float(txfIntroLengua.text!), forKey: "lengua")
            newUser.setValue(Float(txfIntroHisto.text!), forKey: "historia")
            do {
                try context.save()
                
                let Mensaje = UIAlertController(title: "Mensaje", message: "Alumno Guardado", preferredStyle: .alert)
                Mensaje.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler:  nil))
                self.present(Mensaje, animated: true, completion: nil)
                
                txfintronom.text = ""
                txfIntroAPell.text = ""
                txfIntroMAtes.text = ""
                txfIntroLengua.text = ""
                txfIntroHisto.text = ""
            } catch {
                print("Error saving")
            }
        }
    }
    
    
    @IBAction func btnBorrar(_ sender: Any) {
        
        if txfIntroBorrar.text!.isEmpty {
            
            let Mensaje = UIAlertController(title: "Mensaje", message: "Debe introducir el Alumno", preferredStyle: .alert)
            Mensaje.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler:  nil))
            self.present(Mensaje, animated: true, completion: nil)
            
        } else {
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Alumno")
            deleteFetch.predicate = NSPredicate(format: "nombre = %@",txfIntroBorrar.text!)
            let deleteReques = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            // context.delete(encontrar)
            do {
                try context.execute(deleteReques)
                try context.save()
                
                let Mensaje = UIAlertController(title: "Mensaje", message: "Alumno Borrado", preferredStyle: .alert)
                Mensaje.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler:  nil))
                self.present(Mensaje, animated: true, completion: nil)
                
                txfIntroBorrar.text = ""
            }
            catch {
                // Handle Error
            }
        }
    }
    
}
