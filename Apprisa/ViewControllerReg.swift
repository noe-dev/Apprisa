//
//  ViewControllerReg.swift
//  Apprisa
//
//  Created by Sergio Guerrero Olvera on 16/04/21.
//

import UIKit
import SQLite3

class ViewControllerReg: UIViewController
{
    var corr : String = ""
    var nom : String = ""
    
    var admin : AdminBD = AdminBD()

    @IBOutlet weak var txtNom: UITextField!
    @IBOutlet weak var txtCorr: UITextField!
    @IBOutlet weak var txtCont: UITextField!
    
    @IBAction func btnReg(_ sender: UIButton)
    {
        if txtNom.text!.isEmpty || txtCorr.text!.isEmpty || txtCont.text!.isEmpty
        {
            showAlerta(Titulo: "ERROR", Mensaje: "Campos Obligatorios")
            txtNom.becomeFirstResponder()
        }
        else
        {
            let correo = String(txtCorr.text!)
            let nombre = String(txtNom.text!)
            let password = String(txtCont.text!)

            let sentencia = "Insert Into Usuario (corrUsr, nomUsr, contUsr) values ('\(correo)', '\(nombre)', '\(password)')"
            
            if admin.Ejecuta(sentencia: sentencia)
            {
                self.performSegue(withIdentifier: "segueBack", sender: self)
                showAlerta(Titulo: "REGISTRO", Mensaje: "Registro exitoso por favor inicia sesión")
            }
            else
            {
                showAlerta(Titulo: "ERROR", Mensaje: "Falló el registro")
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let query = "Select * from Usuario"
        let apuntadorResult = admin.Consulta(query: query)

        
        if sqlite3_step(apuntadorResult) == SQLITE_ROW
        {
            corr = String(describing: String(cString: sqlite3_column_text(apuntadorResult,0)))
            nom = String(describing: String(cString: sqlite3_column_text(apuntadorResult,1)))
            sqlite3_finalize(apuntadorResult)
        }
        else
        {
            self.performSegue(withIdentifier: "TablaRegUsr", sender: self)
        }
        

        // Do any additional setup after loading the view.
    }
    
    func showAlerta(Titulo : String, Mensaje : String)
    {
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "RegUsrTabla"
        {
            let VC = segue.destination as! UsrTableViewController
            //VC.admin = self.admin
            VC.corr = corr
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        admin.Close()
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
