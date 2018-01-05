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
        let cell = tableView.dequeueReusableCell(withIdentifier:"feedCell", for: indexPath) as! FCFeedTVCell;
        let model = critics[indexPath.row]
        cell.reviewTitle.text = model.ftitle
        cell.reviewDescription.text = model.fsubtitle
        cell.reviewAuthor.text = model.fauthor
        cell.reviewImage.sd_setImage(with: URL(string:model.fimageLink), placeholderImage:UIImage(named:""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
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
            let string = model.reviewLink
            performSegue(withIdentifier:"showDetail", sender: string)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let vc = segue.destination as! FCFeedDetailVC
            vc.linkToShow = sender as! String
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
                        model.ftitle = dictionary["display_name"].stringValue
                        model.fsubtitle = dictionary["bio"].stringValue
                        model.fauthor = dictionary["byline"].stringValue
                        model.fimageLink = dictionary["multimedia"]["src"].stringValue
                        model.reviewLink = dictionary["link"]["url"].stringValue
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
