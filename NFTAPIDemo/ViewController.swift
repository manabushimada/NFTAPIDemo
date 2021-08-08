//
//  ViewController.swift
//  NFTAPIDemo
//
//  Created by Manabu Shimada on 01/08/2021.
//

import UIKit

import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var nftListTableView: UITableView!
    
    
    let decoder: JSONDecoder = JSONDecoder()
    var articles = [Article]()
    var openSea = [OpenSea]()
    var assets = [Assets]()
    
    let urlString = "https://api.opensea.io/api/v1/assets?order_direction=desc&offset=0&limit=20"
    let method: HTTPMethod = .get
    let parameter = ["": ""]
    let encoding: ParameterEncoding = URLEncoding.default
    
    // MARK: setup
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        getQiitaArticles()
        fetchFilms()

    }
    
    
    //MARK:- Alamofire
    private func getQiitaArticles() {
        AF.request("https://qiita.com/api/v2/tags/iOS/items", method: method, parameters: parameter).responseJSON { response in
            
            print(response.result)
            
            switch response.result {
                    
            case .success:
                do {
                    self.articles = try self.decoder.decode([Article].self, from: response.data!);
                    self.nftListTableView.reloadData() }
                catch {
                    print("decode failed")
                    
                }
            case .failure(let error):
                print("error", error)
            }
        }
    }
}

//MARK:- UITableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        articles.count
        self.openSea.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NFTTableViewCell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! NFTTableViewCell
//        let article = articles[indexPath.row]
//        cell.set(title: article.title, author: article.user.id, imageUrl: article.user.imageUrl)
        
        let openSea = self.openSea[indexPath.row]
        cell.set(title: openSea.assets.name, author: String(openSea.assets.id), imageUrl: openSea.assets.imageUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: "WebViewController", bundle: nil)
         let webViewController = storyboard.instantiateInitialViewController() as! WebViewController
//         let article = articles[indexPath.row]
//         webViewController.url = article.url
//         webViewController.title = article.title
        
        let openSea = self.openSea[indexPath.row]
        webViewController.url = openSea.assets.permalink
        webViewController.title = openSea.assets.name
        
         navigationController?.pushViewController(webViewController, animated: true)
     }
    
}

//MARK:- Alamofire
extension ViewController {
  func fetchFilms() {
    AF.request(urlString)
          .responseJSON { response in
            
            print(response.result)
            

            
              let decoder: JSONDecoder = JSONDecoder()
            
            
            
              do {
               // わからん、、、、、、
                
                /*
                self.openSea = try decoder.decode([OpenSea].self, from: response.data!)
                  print(self.openSea)
 */
                let aDictionary : NSDictionary? = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                print("aDictionary", aDictionary)
               
                if let arr = aDictionary!["assets"] as? [NSDictionary] {
                    for elem in arr {
                        print("found")
                        var name: String = ""
                        var id: Int = 0
                        var image_url: String = ""
                        var permalink: String = ""
                        
//                        guard let name: String = elem["name"] as? String else {return}
//                        guard let id: Int = elem["id"] as? Int else {return}
//                        guard let image_url: String = elem["image_url"] as? String else {return}
//                        guard let permalink: String = elem["permalink"] as? String else {return}
                        
                        if let name_ = elem["name"] as? String {
                            name = name_
                        }
                        if let id_ = elem["id"] as? Int {
                            id = id_
                        }
                        if let image_url_ = elem["image_url"] as? String {
                            image_url = image_url_
                        }
                        if let permalink_ = elem["permalink"] as? String {
                            permalink = permalink_
                        }
                        
                        print("  > id", id)
                        print("  > name", name)
                        print("  > image_url", image_url)
                        print("  > permalink", permalink)
                        
                        let assets_ = Assets(name: name, id: id, image_url: image_url, permalink: permalink)
                        
                        let openSea_ = OpenSea(assets: assets_)
                        self.openSea.append(openSea_)
                        
                        
                    }
                }
                
                print ("count", self.openSea.count)
                self.nftListTableView.reloadData()
                
                
              } catch {
                  print("failed")
                  print(error.localizedDescription)
              }

            
      }
  }
}
