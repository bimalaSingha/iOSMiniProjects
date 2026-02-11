//
//  ViewController.swift
//  UITableViewSwift
//
//  Created by K Bimala Singha on 23/01/26.
//


import UIKit

class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let myTableView = UITableView()
//    private let items = ["table", "view", "data", "delegate"]
    private let items = ["Hi, I'm a TableView", "To get me running", "your ViewController needs two protocols", "UITableViewDataSource", "and UITableViewDelegate"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(myTableView)
        myTableView.frame = view.bounds
        
        // first register a standard cell type
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // second set the 'brain' and the 'manager'
        myTableView.dataSource = self
        myTableView.delegate = self
        
    }

    // Data Source     how many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    // what goes in the row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    // Delegate    what happens when I tap a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped on \(items[indexPath.row])!")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

