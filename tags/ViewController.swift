//
//  ViewController.swift
//  tags
//
//  Created by Deekshith Maram on 8/27/18.
//  Copyright © 2018 Deekshith Maram. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    var tagArray: [String] = []
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive:Bool = false
    let data = ["live", "life", "sundance", "event", "zoom", "love", "concert", "king", "cool"]
    
    var filteredData:[String] = []

    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
    
    }
    
    func setupSearchBar(){
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 65))
       
        self.searchTableView.tableHeaderView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            searchActive = false
            view.endEditing(true)
        }else{
            searchActive = true
         filteredData = data.filter { data in
                return data.localizedCaseInsensitiveContains(searchBar.text!)
            }
           print(filteredData,"data")
            
            searchTableView.reloadData()
        }
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive == true{
        return filteredData.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        if searchActive == true{
        cell.resultLabel.text = filteredData[indexPath.row]
            print(filteredData.count,"dixit")
        }else{
            cell.resultLabel.text = "no results"
           
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:TableViewCell = tableView.cellForRow(at: indexPath)! as! TableViewCell
        
        print(selectedCell.resultLabel.text,"text")
        
        tagArray.append(selectedCell.resultLabel.text!)
        print(tagArray,"tagArray")
       
        searchBar.text = ""
        searchActive = false
        searchTableView.reloadData()
        print(tagArray,"tagA")
        self.tagsCollectionView.reloadData()
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionViewCell
      
        cell.tagLabel.text = self.tagArray[indexPath.item]
        
        return cell
    }
    
   

}

