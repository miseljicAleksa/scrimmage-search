// Copyright 2018, Ralf Ebert
// License   https://opensource.org/licenses/MIT
// License   https://creativecommons.org/publicdomain/zero/1.0/
// Source    https://www.ralfebert.de/ios-examples/uikit/choicepopover/
import UIKit

class QuickTableController : UITableViewController {
    
    var customTransitioningDelegate = TransitioningDelegate()
    
    
    typealias SelectionHandler = (Int, Int) -> Void
    
    private let onSelect : SelectionHandler?
    
    var sectionHeight:CGFloat = 80
    var rowHeight:CGFloat = 60
    
    struct Objects {
        var sectionName : String!
        var sectionObjects : [String]!
    }
    
    var objectArray = [Objects]()
    
    init(_ values : [String: [String]], onSelect : SelectionHandler? = nil) {
        self.onSelect = onSelect
        for (key, value) in values {
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
        super.init(style: .plain)
        self.tableView.alwaysBounceVertical = false;
        self.tableView.bounces = false;
        self.tableView.bouncesZoom = false;
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.cornerRadius = 5
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve // use whatever transition you want
        customTransitioningDelegate.height = 260
        transitioningDelegate = customTransitioningDelegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let frame = tableView.frame
        
        //Header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: self.sectionHeight))
        
        //Button
        if(section == 0)
        {
            let button = UIButton(frame: CGRect(x: frame.size.width - 20, y: 15, width: 15, height: 15))
            button.setImage(UIImage(named: "iks"), for: UIControl.State.normal)
            button.addTarget(self, action: #selector(QuickTableController.exitModal), for: .touchUpInside)
            headerView.addSubview(button)
        }
        
        //Bottom Border
        let borderBottom = UIView(frame: CGRect(x:0, y:self.sectionHeight-1, width: tableView.bounds.size.width, height: 3.0))
        borderBottom.backgroundColor = UIColor.coachGrey()
        headerView.addSubview(borderBottom)
        
        //Title
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 300, height: self.sectionHeight))
        label.text = objectArray[section].sectionName
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 19.0)
        //label.font = UIFont(name:"avenirNext-Meduim",size:20)
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let frame = tableView.frame
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: rowHeight))
        //Title
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 300, height: rowHeight))
        label.text = objectArray[indexPath.section].sectionObjects[indexPath.row]
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        //label.font = UIFont(name:"avenirNext-Meduim",size:20)
        cellView.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: frame.size.width - 20, y: 15, width: 15, height: 15))
        button.tag = 11
        button.setImage(UIImage(named: "iks"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(QuickTableController.exitModal), for: .touchUpInside)
        cellView.addSubview(button)
        button.isHidden = true
        
        //Bottom Border
        let borderBottom = UIView(frame: CGRect(x:0, y:rowHeight-1, width: tableView.bounds.size.width, height: 1.0))
        borderBottom.backgroundColor = UIColor.coachGrey()
        cellView.addSubview(borderBottom)
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.contentView.superview?.addSubview(cellView)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        let currentCell = tableView.cellForRow(at: indexPath)!
        currentCell.accessoryType = .checkmark
        tableView.updateConstraintsIfNeeded()
        onSelect?(indexPath.section, indexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //self.dismiss(animated: true)
        let currentCell = tableView.cellForRow(at: indexPath)!
        currentCell.accessoryType = .none
    }
    
    @objc func exitModal() {
        self.dismiss(animated: true)
    }
    
}
