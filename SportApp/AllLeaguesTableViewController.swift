//
//  AllLeaguesTableViewController.swift
//  SportApp
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class AllLeaguesTableViewController: UITableViewController {
    var  strSport : String = ""
    var nameOfLeage : String = ""
    var idOfLeague : String = ""
    var imageOfLeague : String = ""
 
    
    var arr_category_name = [String]()
    var arr_category_image = [String]()
    var arr_category_sport = [String]()
    var arr_category_id = [String]()
    var arr_category_youtube = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
           print(strSport)
        title = strSport
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let myurl = "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s="+strSport
        
        AF.request(myurl, method: .get).responseJSON{
            (myresponse) in
            switch myresponse.result{
            case .success:
                //print(myresponse.result)
                
                let myresult = try? JSON(data:myresponse.data!)
                
                //print(myresult!["leagues"])
                let resultArray = myresult!["countrys"]
                for i in resultArray.arrayValue{
                    
                    //print(i)
                    let sport_name = i["strSport"].stringValue
                   
                        
                        let league_name = i["strLeague"].stringValue
                        self.arr_category_name.append(league_name)
                        
                        let sport_id = i["idLeague"].stringValue
                        self.arr_category_id.append(sport_id)
                       
                         let league_youtube = i["strYoutube"].stringValue
                         self.arr_category_youtube.append(league_youtube)
                        
                      let sport_image = i["strBadge"].stringValue
                      self.arr_category_image.append(sport_image)
                        //print(i)
                        
                    
                    
                    
                    
                }
                self.tableView.reloadData()
                break
                
            case .failure:
                print(myresponse.error!)
                break
            }
        }
       
       
            
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr_category_name.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let  title:UILabel = cell.viewWithTag(2) as! UILabel
        let  image:UIImageView = cell.viewWithTag(1) as! UIImageView
        //let youtubeBtn:UIButton = cell.viewWithTag(3) as! UIButton
        
        title.text = arr_category_name[indexPath.row]
        //image.image = UIImage(named: arr_category_image[indexPath.row])
         image.sd_setImage(with: URL(string: arr_category_image[indexPath.row]), placeholderImage: UIImage(named: "sport.jpg"))
        
       // youtubeBtn.buttonType
        
       
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170;
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        
        if let url = NSURL(string: "http://" + arr_category_youtube[indexPath.row]){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nameOfLeage  =  arr_category_name[indexPath.row]
        idOfLeague = arr_category_id[indexPath.row]
        imageOfLeague = arr_category_image[indexPath.row]
        
        //forsegue
        self.performSegue(withIdentifier: "fromAlltoDetails", sender: idOfLeague )
        self.performSegue(withIdentifier: "fromAlltoDetails", sender: nameOfLeage )
        self.performSegue(withIdentifier: "fromAlltoDetails", sender: imageOfLeague )
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let detailLeaguevc : LeagueDetailsCollectionViewCell = segue.destination as!
            LeagueDetailsCollectionViewCell
            detailLeaguevc.strLeague = idOfLeague
            detailLeaguevc.strLeageName = nameOfLeage
            detailLeaguevc.strLeageImage = imageOfLeague
            //self.navigationController?.pushViewController(allLeagvc, animated: true)
            
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
