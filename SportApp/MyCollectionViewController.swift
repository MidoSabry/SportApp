//
//  MyCollectionViewController.swift
//  SportApp
//
//  Created by MacOSSierra on 2/16/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

private let reuseIdentifier = "Cell"

class MyCollectionViewController: UICollectionViewController {
    
    var nameOfSport : String = ""
    
    var arr_category_id = [String]()
    var arr_category_name = [String]()
    var arr_category_image = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        var layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
//        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width-1)/2, height: (self.collectionView.frame.size.height-1)/2)
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
            
            
            
            
      //navigationItem.title="Sports App"
       title="Sports App"
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let myurl = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
        AF.request(myurl, method: .get).responseJSON{
            (myresponse) in
            switch myresponse.result{
            case .success:
                //print(myresponse.result)
                
                let myresult = try? JSON(data:myresponse.data!)
                
                //print(myresult!["sports"])
                let resultArray = myresult!["sports"]
                for i in resultArray.arrayValue{
                    
                    //print(i)
                    let sport_id = i["idSport"].stringValue
                    self.arr_category_id.append(sport_id)
                    
                    let sport_name = i["strSport"].stringValue
                    self.arr_category_name.append(sport_name)
                    
                    let sport_image = i["strSportThumb"].stringValue
                    self.arr_category_image.append(sport_image)
                   
                }
                self.collectionView.reloadData()
                break
                
            case .failure:
                print(myresponse.error!)
                break
            }
        }
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.hidesBarsOnTap = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.hidesBarsOnTap = false
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arr_category_id.count
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    
        // Configure the cell
          let  title:UILabel = cell.viewWithTag(1) as! UILabel
          let  image:UIImageView = cell.viewWithTag(2) as! UIImageView
        
      
           title.text = arr_category_name[indexPath.row]
            image.sd_setImage(with: URL(string: arr_category_image[indexPath.row]), placeholderImage: UIImage(named: "sport.jpg"))
      
        
        
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let nextviewcontroller : AllLeaguesTableViewController = (self.storyboard?.instantiateViewController(withIdentifier:"secVc" ) as! AllLeaguesTableViewController)
       nextviewcontroller.strSport = arr_category_name[indexPath.row]
       // self.navigationController?.show(nextviewcontroller, sender: nil)
        
        let allLeagvc : AllLeaguesTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "secVc") as! AllLeaguesTableViewController
        //print(allLeagvc)
       self.navigationController?.pushViewController(allLeagvc, animated: true)
        
        nameOfSport = arr_category_name[indexPath.row]
        allLeagvc.strSport = nameOfSport
        
        //forsegue
       //self.performSegue(withIdentifier: "fromMyToAll", sender: nameOfSport)
        
      
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250.0, height: 200.0)
    }
 

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       let allLeagvc : AllLeaguesTableViewController = segue.destination as!
//        AllLeaguesTableViewController
//        allLeagvc.strSport = nameOfSport
//        //self.navigationController?.pushViewController(allLeagvc, animated: true)
//        print("selected")
//    }

   

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    

}
