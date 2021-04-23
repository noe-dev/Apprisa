//
//  TableViewControllerUsr.swift
//  Apprisa
//
//  Created by Sergio Guerrero Olvera on 21/04/21.
//

import UIKit
import SQLite3

class TableViewControllerUsr: UITableViewController
{
    var Pedidos = [Pedido]()
    var pedi = Pedido(Cod: 0, DirCte: "", DirPed: "", Desc: "", Fec: "", Tel: 0, Extra: "")
    
    @IBOutlet var tabla: UITableView!
    
    var admin : AdminBD = AdminBD()
    
    var corr : String = ""
    var nom : String = ""
    
    @IBAction func btnAdd(_ sender: UIBarButtonItem)
    {
        self.performSegue(withIdentifier: "seguePed", sender: self)
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
            
            let sentencia = "Select * from Pedido order by dirPed"
            let apuntadorPed = admin.Consulta(query: sentencia)
            
            while sqlite3_step(apuntadorPed) == SQLITE_ROW
            {
                let ped = String(cString: sqlite3_column_text(apuntadorPed, 2))
                let desc = String(cString: sqlite3_column_text(apuntadorPed, 3))
                
                Pedidos.append(Pedido(Cod: 0, DirCte: "", DirPed: ped, Desc: desc, Fec: "", Tel: 0, Extra: ""))
            }
            tabla.reloadData()
        }
        else
        {
            self.performSegue(withIdentifier: "seguePed", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        RecargaTabla()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        admin.Close()
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return Pedidos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda") as!  TableViewCellPed
        let ped : Pedido
        
        ped = Pedidos[indexPath.row]
        cell.lblDesc.text = ped.dirped
        cell.lblPed.text = ped.desc
        // Configure the cell...
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        RecargaTabla()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        pedi = Pedidos[indexPath.row]
        performSegue(withIdentifier: "seguePed", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
            let delete = UIContextualAction(style: .destructive, title: "Borrar", handler: { _, _, _ in
            let ped = self.Pedidos[indexPath.row]
            let sentencia = "Delete from Pedido where idPed = " + String(ped.cod)
                
            if self.admin.Ejecuta(sentencia: sentencia)
            {
                self.RecargaTabla()
            }
        })
        
        delete.image = UIImage(named: "trash")
        delete.backgroundColor = UIColor(named: "custom-red")
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "seguePed"
        {
            let vc = segue.destination as! ViewController
            
        }
    }*/
    
    func RecargaTabla()
    {
        var pedidosX = [Pedido]()
        let sentencia = "Select * from Pedido order by dirPed"
        let apuntadoProd = admin.Consulta(query: sentencia)
        
        while (sqlite3_step(apuntadoProd) == SQLITE_ROW)
        {
            let dirped = String(cString : sqlite3_column_text(apuntadoProd, 2))
            let desc = String(cString : sqlite3_column_text(apuntadoProd, 3))
            
            pedidosX.append(Pedido(Cod: 0, DirCte: "", DirPed: dirped, Desc: desc, Fec: "", Tel: 0, Extra: ""))
        }
        Pedidos = pedidosX
        tabla.reloadData()
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
