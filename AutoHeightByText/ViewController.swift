//
//  ViewController.swift
//  AutoHeightByText
//
//  Created by John Lima on 18/01/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate let cellName = "cell"
    fileprivate let headerHeight: CGFloat = 44
    fileprivate let model = Model()
    fileprivate var tableData = DictionaryModel()
    fileprivate var sections = [String]()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        updateUI()
    }
    
    // MARK: - Actions
    fileprivate func updateUI() {
        
        let footer = UIView(frame: .zero)
        
        tableView.tableFooterView = footer
        tableView.backgroundColor = Colors.lightBlack
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    fileprivate func getData() {
        
        guard let data = model.getDictionaryData(from: model.getData()), let dictionary = data.data, dictionary.count > 0 else { return }
        tableData = dictionary
        sections = data.keys
    }
    
    fileprivate func configureHeaderView(section: Int) -> (height: CGFloat, view: UIView)? {
        
        let section = sections[section]
        
        let sectionLabel = CustomLabel()
        sectionLabel.text = section.uppercased()
        sectionLabel.textColor = .white
        sectionLabel.numberOfLines = 0
        sectionLabel.lineBreakMode = .byTruncatingTail
        sectionLabel.backgroundColor = .darkGray
        sectionLabel.font = Fonts.chalkboardSEMinorSize
        sectionLabel.leftEdge = 16
        sectionLabel.rightEdge = 16
        
        guard let fontLabel = sectionLabel.font, let text = sectionLabel.text else { return nil }
        
        let widthView = view.frame.size.width
        var height = CGFloat.heightWithConstrainedWidth(string: text, width: widthView, font: fontLabel)
        
        height += headerHeight / 5
        
        sectionLabel.frame.size = CGSize(width: widthView, height: height)
        
        return (height, sectionLabel)
    }
    
    // MARK: - UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = tableData[sections[section]] {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        
        let label = cell.viewWithTag(1) as? UILabel
        
        let items = tableData[sections[indexPath.section]]?.sorted { $0.getMessage()! < $1.getMessage()! }
        let item = items?[indexPath.row]
        
        label?.text = item?.getMessage()?.uppercased()
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let height = configureHeaderView(section: section)?.height {
            return height
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return configureHeaderView(section: section)?.view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

