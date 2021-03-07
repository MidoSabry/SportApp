//
//  TeamDetailsViewController.swift
//  SportApp
//
//  Created by MacOSSierra on 3/2/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class TeamDetailsViewController: UICollectionViewController {
   
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var teamID : String = ""
    
    var arr_team_name = [String]()
    var arr_team_image = [String]()
    var arr_team_country = [String]()
    var arr_team_stadum = [String]()
    var arr_team_league = [String]()
    var arr_team_website = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hi")
        // Do any additional setup after loading the view.
        
        let mydata = "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=" + teamID
        
        AF.request(mydata, method: .get).responseJSON { (myresponse) in
            switch myresponse.result {
            case .success:
                //print(myresponse.result)
                let result = try? JSON(data: myresponse.data!)
                //print(result)
                //print(result!["sports"])
                let resultArray = result!["teams"]
                
               // self.arr_team_details.removeAll()
                
                
                for i in resultArray.arrayValue{
                    let team_name = i["strTeam"].stringValue
                    self.arr_team_name.append(team_name)
                    
                    let team_img = i["strTeamBadge"].stringValue
                    self.arr_team_image.append(team_img)
                    
                    let team_country = i["strCountry"].stringValue
                    self.arr_team_country.append(team_country)
                    
                    let team_stadum = i["strStadium"].stringValue
                    self.arr_team_stadum.append(team_stadum)
                    
                    let team_league = i["strLeague"].stringValue
                    self.arr_team_league.append(team_league)
                    
                    let team_website = i["strWebsite"].stringValue
                    self.arr_team_website.append(team_website)
                    
                    
                    
                    self.collectionView.reloadData()
                    //print(finaldetailsteam.country)
                    
                    //print(finaldetailsteam.teamid)
                }
                break;
            case .failure:
                break
            }
        }
        
        
        
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arr_team_image.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "te", for: indexPath)
        
        let teamname:UILabel = cell.viewWithTag(1) as! UILabel
        let teamcountry:UILabel = cell.viewWithTag(2) as! UILabel
        let teamstadum:UILabel = cell.viewWithTag(3) as! UILabel
        let  teamleague : UILabel = cell.viewWithTag(4) as! UILabel
        let  teamwebsite : UILabel = cell.viewWithTag(5) as! UILabel
        let  teamimage:UIImageView = cell.viewWithTag(6) as! UIImageView
        
        teamimage.sd_setImage(with: URL(string: arr_team_image[indexPath.row]), placeholderImage: UIImage(named: "sport.jpg"))
       
        
        teamname.text = arr_team_name[indexPath.row]
        teamcountry.text = arr_team_country[indexPath.row]
        teamstadum.text = arr_team_stadum[indexPath.row]
        teamleague.text = arr_team_league[indexPath.row]
        teamwebsite.text = arr_team_website[indexPath.row]
        
        
        return cell
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
