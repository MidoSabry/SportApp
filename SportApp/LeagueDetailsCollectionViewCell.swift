//
//  LeagueDetailsCollectionViewCell.swift
//  SportApp
//
//  Created by MacOSSierra on 2/28/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData

class LeagueDetailsCollectionViewCell: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var  strLeague : String = ""
    var strLeageName : String = ""
    var strLeageImage : String = ""
    
    
    @IBOutlet weak var first_cell: UICollectionView!
    
    @IBOutlet weak var second_cell: UICollectionView!
    
   
    @IBOutlet weak var third_cell: UICollectionView!
    
    
    var sportsArray = [NSManagedObject]()
    @IBAction func addBtn(_ sender: Any) {
        //1 app delgate
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2 manage object context
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        //3 create entity object
        
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteSports", in: manageContext)
        
        
        // 4 create manage object for movie entity
        
        let sport = NSManagedObject(entity: entity!, insertInto: manageContext)
       
        //5 set values for the manage object
        sport.setValue(strLeague, forKey: "id")
        sport.setValue(strLeageName, forKey: "title")
        sport.setValue(strLeageImage, forKey: "image")
        
        
        //6 Save
        do{
            
            try manageContext.save()
            //try movie.managedObjectContext?.save()
            sportsArray.append(sport)
            print("data added")
            print(sportsArray)
            
            
        }catch let error{
            
            print(error)
            
        }
        //let favouritLeaguevc = MyFavouritTableViewController()
        
        //self.navigationController?.pushViewController(favouritLeaguevc, animated: true)
        
    }
    
    
   
    
    
    var arr_event_name = [String]()
    var arr_event_data = [String]()
    var arr_event_time = [String]()
    
    var arr_home_team = [String]()
    var arr_second_team = [String]()
    var arr_first_score = [String]()
    var arr_second_score = [String]()
    var arr_the_date = [String]()
    var arr_the_time = [String]()
    
    var arr_teame_image = [String]()
    var arr_team_id = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(strLeageName)
        print(strLeague)
        
        // Do any additional setup after loading the view.
        let dataevents = "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=" + strLeague
        
        AF.request(dataevents, method: .get).responseJSON { (myresponse) in
            switch myresponse.result {
            case .success:
                
                let result = try? JSON(data: myresponse.data!)
                
                let resultArray = result!["events"]
                
                
                
                
                for i in resultArray.arrayValue{
                    
                    
                    
                    let league_eventname = i["strEvent"].stringValue
                    self.arr_event_name.append(league_eventname)
                    
                    let league_eventdate = i["dateEvent"].stringValue
                    self.arr_event_data.append(league_eventdate)
                    
                    let league_eventtime = i["strTime"].stringValue
                    self.arr_event_time.append(league_eventtime)
                    
                    
                    let home_team = i["strHomeTeam"].stringValue
                    self.arr_home_team.append(home_team)
                    
                    let away_team = i["strAwayTeam"].stringValue
                    self.arr_second_team.append(away_team)
                    
                    let hometeam_score = i["intHomeScore"].stringValue
                    self.arr_first_score.append(hometeam_score)
                    
                    let awayteam_score = i["intAwayScore"].stringValue
                    self.arr_second_score.append(awayteam_score)
                    
                    
                   
                    
                    
                    //print(self.arr_event_name)
                    //print(self.arr_event_data)
                    //print(self.arr_event_time)
                    //print(self.arr_second_score)
                    // print(self.arr_teame_image)
                    
                }
                self.first_cell.reloadData()
                self.second_cell.reloadData()
               
                
                break;
            case .failure:
                print(myresponse.error!)
                break
            }
        }
        
        
        
        let teamdata = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=" + strLeague
        AF.request(teamdata, method: .get).responseJSON { (myresponse) in
            switch myresponse.result {
            case .success:
                //print(myresponse.result)
                let result = try? JSON(data: myresponse.data!)
                //print(result)
                let resultArray = result!["teams"]
                
                for i in resultArray.arrayValue{
                    
                    let team_id = i["idTeam"].stringValue
                    self.arr_team_id.append(team_id)
                   
                    
                    let team_img = i["strTeamLogo"].stringValue
                    self.arr_teame_image.append(team_img)
                    
                    
                    
                    
                    self.third_cell.reloadData()
                    
                }
                break;
            case .failure:
                break
            }
        }
       
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if(collectionView == first_cell){
            return arr_event_data.count
        }
        if(collectionView == second_cell){
            return arr_event_data.count

        }
        return arr_event_data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if(collectionView == first_cell){
            let cell = first_cell.dequeueReusableCell(withReuseIdentifier: "fcell", for: indexPath)

            let  eventname:UILabel = cell.viewWithTag(1) as! UILabel
            let  eventtime:UILabel = cell.viewWithTag(2) as! UILabel
            let  eventdate:UILabel = cell.viewWithTag(3) as! UILabel

            eventname.text = arr_event_name[indexPath.row]
            eventtime.text = arr_event_time[indexPath.row]
            eventdate.text = arr_event_data[indexPath.row]
            

            return cell

        }
        
        if(collectionView == second_cell){
            
            let cell2 = second_cell.dequeueReusableCell(withReuseIdentifier: "scell", for: indexPath)
            let hometeamname:UILabel = cell2.viewWithTag(1) as! UILabel
            let  secondteamname : UILabel = cell2.viewWithTag(2) as! UILabel
            let hometeamscore:UILabel = cell2.viewWithTag(3) as! UILabel
            let secondteamscore: UILabel = cell2.viewWithTag(4) as! UILabel
            let eventtime:UILabel = cell2.viewWithTag(5) as! UILabel
            let eventdate : UILabel = cell2.viewWithTag(6) as! UILabel
            
            
            hometeamname.text = arr_home_team[indexPath.row]
            secondteamname.text = arr_second_team[indexPath.row]
            hometeamscore.text = arr_first_score[indexPath.row]
            secondteamscore.text = arr_second_score[indexPath.row]
            eventtime.text = arr_event_time[indexPath.row]
            eventdate.text = arr_event_data[indexPath.row]
            
           // print(arr_home_team[indexPath.row])
            
            
            
            
            return cell2
            
            
        }
        
        if(collectionView == third_cell){
            
            let cell3 = third_cell.dequeueReusableCell(withReuseIdentifier: "thcell", for: indexPath) as! UICollectionViewCell
            
            let  img:UIImageView = cell3.viewWithTag(8) as! UIImageView
            img.sd_setImage(with: URL(string: arr_teame_image[indexPath.row]), placeholderImage: UIImage(named: "sport.jpg"))
            img.layer.cornerRadius = img.frame.size.width / 2
            img.clipsToBounds = true
            return cell3
            
            
        }
        let cellfinal = collectionView.dequeueReusableCell(withReuseIdentifier: "Events", for: indexPath)


        return cellfinal
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let TeamVC = self.storyboard?.instantiateViewController(withIdentifier: "te") as! TeamDetailsViewController
        TeamVC.teamID = arr_team_id[indexPath.row]
        self.present(TeamVC, animated: true, completion: nil)
        //print(Fnext.teamDetails.teamid)
        print("pressed")
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
