//
//  ViewController.swift
//  Apprisa
//
//  Created by Sergio Guerrero Olvera on 29/03/21.
//

import UIKit
import SQLite3

class ViewController: UIViewController
{
    
    @IBOutlet weak var txtCorr: UITextField!
    @IBOutlet weak var txtPsw: UITextField!
    @IBOutlet weak var btnSes: UIButton!
    
    @IBAction func btnYa(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "LoginRegUsr", sender: self)
    }
    
    var admin : AdminBD = AdminBD()
    var corr : String = ""
    var nom : String = ""
    
    
   /* @IBAction func btnSes(_ sender: UIButton)
    {
        txtCorr.becomeFirstResponder()
        
        if txtCorr.text!.isEmpty || txtPsw.text!.isEmpty
        {
            showAlerta(Titulo: "Obligatorio", Mensaje: "Campos Obligatorios")
        }
    }*/
    
    /*func btnClicked(_ sender: AnyObject?)
    {
        if sender === btnSes
        {
            if  txtCorr.text!.isEmpty || txtPsw.text!.isEmpty
            {
                showAlerta(Titulo: "Obligatorio", Mensaje: "Campos Obligatorios")
            }
        }
    }*/
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnSes.layer.cornerRadius = 15
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let query = "Select * from Usuario"
        let apuntadorResult = admin.Consulta(query: query)

        
        if sqlite3_step(apuntadorResult) == SQLITE_ROW
        {
            corr = String(describing: String(cString: sqlite3_column_text(apuntadorResult,0)))
            nom = String(describing: String(cString: sqlite3_column_text(apuntadorResult,1)))
        }
        else
        {
            self.performSegue(withIdentifier: "TablaRegUsr", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        txtCorr.becomeFirstResponder()
    }
    
    
    func showAlerta(Titulo : String, Mensaje : String)
    {
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        admin.Close()
    }
}
