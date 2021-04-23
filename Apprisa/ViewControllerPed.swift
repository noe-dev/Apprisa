//
//  ViewControllerPed.swift
//  Apprisa
//
//  Created by Sergio Guerrero Olvera on 21/04/21.
//
import SQLite3
import UIKit

class ViewControllerPed: UIViewController
{
    var admin : AdminBD = AdminBD()
    
    @IBOutlet weak var txtCod: UITextField!
    @IBOutlet weak var txtDirCte: UITextField!
    @IBOutlet weak var txtDirPed: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtTel: UITextField!
    @IBOutlet weak var txtExt: UITextField!
    
    var cod : Int = 0
    var dircte : String = ""
    var dirped : String = ""
    var desc : String = ""
    var fecha : String = ""
    var telefono : Int = 0
    var extra : String = ""
    var ped = Pedido(Cod: 0, DirCte: "", DirPed: "", Desc: "", Fec: "", Tel: 0, Extra: "")
    
    @IBAction func btnPedido(_ sender: UIButton)
    {
        var sentencia : String = ""
        var query : String = ""
        
        if txtCod.text!.isEmpty || txtDirCte.text!.isEmpty || txtDirPed.text!.isEmpty || txtDesc.text!.isEmpty || txtDate.text!.isEmpty || txtTel.text!.isEmpty || txtExt.text!.isEmpty
        {
            showAlerta(Titulo: "Datos insuficientes", Mensaje: "Faltan datos para realizar el pedido")
            txtCod.becomeFirstResponder()
        }
        else
        {
            if cod > 0
            {
                cod = Int(txtCod.text!)!
                dircte = String(txtDirCte.text!)
                dirped = String(txtDirCte.text!)
                desc = String(txtDirCte.text!)
                fecha = String(txtDirCte.text!)
                telefono = Int(txtTel.text!)!
                extra = String(txtDirCte.text!)

                query = "Update Pedido set dirCte = '\(dircte)', dirPed = '\(dirped)', descripcion = '\(desc)', telefono = \(telefono), fecha = '\(fecha)', extra = '\(extra)' where idPed = \(cod)"
                
                if admin.Ejecuta(sentencia: query)
                {
                    performSegue(withIdentifier: "segueRegPed", sender: self)
                }
                
                txtCod.becomeFirstResponder()
            }
            else
            {
                cod = Int(txtCod.text!)!
                dircte = String(txtDirCte.text!)
                dirped = String(txtDirCte.text!)
                desc = String(txtDirCte.text!)
                fecha = String(txtDirCte.text!)
                telefono = Int(txtTel.text!)!
                extra = String(txtDirCte.text!)
                
                sentencia = "Insert into Pedido(idPed, dirCte, dirPed, descripcion, telefono, fecha, extra) values (\(cod), '\(dircte)', '\(dirped)', '\(desc)', \(telefono), '\(fecha)', '\(extra)');"
                
                txtCod.becomeFirstResponder()
            }
            if admin.Ejecuta(sentencia: sentencia)
            {
                txtCod.text = ""
                txtDirCte.text = ""
                txtDirPed.text = ""
                txtDesc.text = ""
                txtTel.text = ""
                txtExt.text = ""
                txtDate.text = ""
                
                showAlerta(Titulo: "REALIZANDO PEDIDO", Mensaje: "El pedido se realizó con exito")
                txtCod.becomeFirstResponder()
            }
            else
            {
                txtCod.text = ""
                txtDirCte.text = ""
                txtDirPed.text = ""
                txtDesc.text = ""
                txtTel.text = ""
                txtExt.text = ""
                txtDate.text = ""
                
                showAlerta(Titulo: "ERROR", Mensaje: "No se realizó el pedido; faltan datos")
                txtCod.becomeFirstResponder()
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if cod > 0
        {
            txtCod.text = String(cod)
            txtDirCte.text = dircte
            txtDirPed.text = dirped
            txtDesc.text = desc
            txtDate.text = fecha
            txtTel.text = String(telefono)
            txtExt.text = extra
            
            txtCod.becomeFirstResponder()
        }
        txtCod.becomeFirstResponder()
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
    
    func showAlerta(Titulo : String, Mensaje : String)
    {
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
