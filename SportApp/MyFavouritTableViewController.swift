//
//  MyFavouritTableViewController.swift
//  SportApp
//
//  Created by MacOSSierra on 2/16/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import Alamofire


class MyFavouritTableViewController: UITableViewController {
    var  strSport : String = ""
    var nameOfLeage : String = ""
    var idOfLeague : String = ""
    var imageOfLeague : String = ""
    
    
   
    
    
    var sportsArray = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        title = "My Favourite"
        print("data show")
        
        //1 app delgate
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2 manage object context
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        //3 create fetch request
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteSports")
        
        
        //    let prdictae = NSPredicate(format: "title == %@", "Movie1")
        
        //        fetchRequest.predicate = prdictae
        
        
        do{
            sportsArray = try manageContext.fetch(fetchRequest)
            print("data show")
            
            
        }catch let error{
            
            
            print(error)
            
        }
        self.tableView.reloadData();
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sportsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let  title:UILabel = cell.viewWithTag(2) as! UILabel
        let  image:UIImageView = cell.viewWithTag(1) as! UIImageView
        
        title.text = (sportsArray[indexPath.row].value(forKey: "title") as! String)
        image.sd_setImage(with: URL(string: sportsArray[indexPath.row].value(forKey: "image") as! String), placeholderImage: UIImage(named: "sport.jpg"))
        
        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if Connectivity.isConnectedToInternet {
       
        idOfLeague = sportsArray[indexPath.row].value(forKey: "id") as! String
 
            //forsegue
        self.performSegue(withIdentifier: "fromAlltoDetails2", sender: idOfLeague )
  
            print("pressed")
        } else {
            print("no connection")
            let alert = UIAlertController(title: "Alert", message: "connection failed", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailLeaguevc : LeagueDetailsCollectionViewCell = segue.destination as!
        LeagueDetailsCollectionViewCell
        detailLeaguevc.strLeague = idOfLeague
       
        
        
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
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //1 app delgate
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            //2 manage object context
            
            let manageContext = appDelegate.persistentContainer.viewContext
            
            
            //3 delete from manage context
            
            manageContext.delete(sportsArray[indexPath.row])
            
            
            do{
                
                try manageContext.save()
                
                
            }catch let error{
                
                print(error)
            }
            
            sportsArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

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



