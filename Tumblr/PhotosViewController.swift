//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by user143116 on 9/10/18.
//  Copyright © 2018 MSU. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    
    var posts: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.rowHeight = 250
        
        TableView.dataSource = self

        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                self.TableView.reloadData()
            }
        
        }
        task.resume()
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            
            let post = posts[indexPath.row]
            if let photos = post["photos"] as? [[String: Any]] {
            
            // 1.
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)
            cell.picture.af_setImage(withURL: url!)
            }
            
            
            
            return cell
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photodetailViewController = segue.destination as! PhotoDetailsViewController
        let cell = sender as! PhotoCell
        if let indexPath = TableView.indexPath(for: cell) {
            photodetailViewController.image = cell.picture.image!
            
        }
   
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   
    }



