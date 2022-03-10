//
//  ViewController.swift
//  MWTableViewCellSeparatorLineSwift
//
//  Created by LiY on 03/10/2022.
//  Copyright (c) 2022 LiY. All rights reserved.
//

import UIKit
import MWTableViewCellSeparatorLineSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = "\(indexPath.row)"
        switch indexPath.row {
        case 0:
            cell?.setSeparatorLineStyle([.display(.show(l: 30, r: 0))])
        case 1:
            cell?.setSeparatorLineStyle([.display(.show(l: 30, r: 50))])
        case 2:
            cell?.setSeparatorLineStyle([.height(8)])
        case 3:
            cell?.setSeparatorLineStyle([.display(.hidden)])
        case 4:
            cell?.setSeparatorLineStyle([.color(UIColor.purple)])
        case 5:
            cell?.setSeparatorLineStyle([.display(.show(l: 0, r: 0)), .color(UIColor.red)])
        default: break
        }
        
        return cell!
    }
    
    // MARK: - Table view delegate

}

