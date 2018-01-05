//
//  FCCriticsFeedVC.swift
//  Movie Review
//
//  Created by Kostya on 05.01.2018.
//  Copyright © 2018 SKS. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class FCCriticsFeedVC: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    let ApiUrl = "https://api.nytimes.com/svc/movies/v2/critics/all.json"
    let NYTApikey = "8eb28054a4c94c4a952206fd007a9f05"
    var critics = [FCFeedModel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.getCriticsFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let model = critics[indexPath.row]
        let bio = model.fsubtitle as String
        
        if(bio.count>1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"feedCell1", for: indexPath) as! FCFeedTVCell;
            cell.reviewTitle.text = model.ftitle
            cell.reviewDescription.text = model.fsubtitle
            cell.reviewAuthor.text = model.fauthor
            cell.reviewImage.sd_setImage(with: URL(string:model.fimageLink), placeholderImage:UIImage(named:""))
            cell.reviewImage.layer.cornerRadius = 20
            cell.reviewImage.clipsToBounds = true
            if(model.fimageLink.count>1)
            {
                cell.avatarStatus.text = ""
            }
            else
            {
                cell.avatarStatus.text = "No Avatar"
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"FCCriticsTVCell", for: indexPath) as! FCCriticsTVCell;
            cell.criticName.text = model.fauthor
            cell.criticSEO.text = model.seoName
            cell.criticStatus.text = model.ftitle
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let model = critics[indexPath.row]
        let bio = model.fsubtitle as String
        
        if(bio.count>1)
        {
            return 180
        }
        else
        {
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return critics.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        
        if cell != nil
        {
            let model = critics[indexPath.row]
            let bio = model.fsubtitle as String
            if(bio.count>1)
            {
                let model = critics[indexPath.row]
                performSegue(withIdentifier:"showDetailedModel", sender: model)
            }
            else
            {
                let alert = UIAlertController(title: "Sorry!", message: "For this critic the full information are unavaliable.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetailedModel") {
            let vc = segue.destination as! FCCriticsDetailedVC
            vc.model = sender as! FCFeedModel
        }
    }
    
    func getCriticsFromServer()
    {
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["api-key"] = NYTApikey
        Alamofire.request(ApiUrl, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            if let data = response.data
            {
                do{
                    var json = try JSON(data:data)
                    let list = json["results"].arrayValue
                    for dictionary in list
                    {
                        let model = FCFeedModel()
                        model.ftitle = dictionary["status"].stringValue
                        let subtitle = dictionary["bio"].stringValue
                        model.fsubtitle = subtitle.replacingOccurrences(of: "<br/><br/>", with: "")
                        model.fauthor = dictionary["display_name"].stringValue
                        model.fimageLink = dictionary["multimedia"]["resource"]["src"].stringValue
                        model.seoName = dictionary["seo_name"].stringValue
                    
                        self.critics.append(model)
                    }
                    
                } catch{print(error)}
                
            }
            self.tableView.reloadData()
            let userDefaults = UserDefaults(suiteName: "group.watch.movie")
            userDefaults?.set("array", forKey: "arrayOfMovies")
            userDefaults?.synchronize()
        }
    }

}
