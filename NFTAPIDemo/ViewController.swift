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
       getQiitaArticles()
       //fetchFilms()

    }
    
    
    //MARK:- Alamofire
    private func getQiitaArticles() {
        AF.request("https://qiita.com/api/v2/tags/iOS/items", method: method, parameters: parameter).responseJSON { response in
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
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NFTTableViewCell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! NFTTableViewCell
        let article = articles[indexPath.row]
        cell.set(title: article.title, author: article.user.id, imageUrl: article.user.imageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: "WebViewController", bundle: nil)
         let webViewController = storyboard.instantiateInitialViewController() as! WebViewController
         let article = articles[indexPath.row]
         webViewController.url = article.url
         webViewController.title = article.title
         navigationController?.pushViewController(webViewController, animated: true)
     }
    
}

//MARK:- Alamofire
extension ViewController {
  func fetchFilms() {
    AF.request(urlString)
          .responseJSON { response in
              let decoder: JSONDecoder = JSONDecoder()
              do {
               // わからん、、、、、、
                self.openSea = try decoder.decode([OpenSea].self, from: response.data!)
                  print(self.openSea)
                
              } catch {
                  print("failed")
                  print(error.localizedDescription)
              }
      }
  }
}
