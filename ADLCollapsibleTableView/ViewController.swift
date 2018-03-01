//
//  ViewController.swift
//  ADLCollapsibleTableView
//
//  Created by Arshwin Denuev Lal P M on 01/03/18.
//  Copyright © 2018 Arshwin Denuev Lal P M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var headerContents = ["Auto resizing section header",
                          "Auto resizing section header\nAuto resizing section header",
                          "Auto resizing section header\nAuto resizing section header\nAuto resizing section header",
                          "Auto resizing section header\nAuto resizing section header\nAuto resizing section header\nAuto resizing section header",
                          "Auto resizing section header\nAuto resizing section header\nAuto resizing section header\nAuto resizing section header\nAuto resizing section header"]
    var rowContents =    ["Auto resizing tableViewCell",
                          "Auto resizing tableViewCell\nAuto resizing tableViewCell",
                          "Auto resizing tableViewCell\nAuto resizing tableViewCell\nAuto resizing tableViewCell"]
    
    var isSelected = [false,false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedSectionHeaderHeight = 70
        tableView.sectionFooterHeight = 1
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//UITableViewDelegate
extension ViewController : UITableViewDelegate {
    
    @objc func headerTapped(_ sender : UIGestureRecognizer) {
        isSelected[(sender.view?.tag)!] = !isSelected[(sender.view?.tag)!]
        let view = sender.view
        //set tag = 999 for views to rotate
        
        /*
        //Use if there is only a single view to rotate
        if let subView = view?.viewWithTag(999) {
            isSelected[(sender.view?.tag)!] ? subView.rotate(.pi/2) : subView.rotate(0)
        }
        */
        
        //Use if there are multiple views to rotate
        for subView in (view?.subviews)! {
            if subView.tag == 999 {
                UIView.animate(withDuration: 0.3, animations: {
                    subView.transform = subView.transform.rotated(by: self.isSelected[(sender.view?.tag)!] ? .pi/2 : -.pi/2)
                })
            }
        }
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

//UITableViewDataSource
extension ViewController : UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerContents.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowContents.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard isSelected[indexPath.section] else {
            return 0
        }
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.headerTapped(_:)))
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as? CollapsibleTableViewCell
        cell?.titleLabel.text = headerContents[section]
        cell?.contentView.tag = section
        cell?.contentView.addGestureRecognizer(tapGesture)
        return cell?.contentView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell") as? CollapsibleTableViewCell
        cell?.titleLabel.text = rowContents[indexPath.row]
        return cell!
    }
}

