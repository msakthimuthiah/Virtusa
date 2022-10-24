
import UIKit
import PKHUD

class PeopleItemListViewController: UIViewController {


    // MARK: - Properties
    var presenter: ViewToPresenterPeopleItemListProtocol?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
}

extension PeopleItemListViewController: PresenterToViewPeopleItemListProtocol{
    
    func onFetchPeopleItemListSuccess() {
        print("View receives the response from Presenter and updates itself.")
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchPeopleItemListFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        self.refreshControl.endRefreshing()
    }
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
    func deselectRowAt(row: Int) {
        self.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
    }
    
}

// MARK: - UITableView Delegate & Data Source
extension PeopleItemListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return presenter?.numberOfSections() ?? 0  
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PeopleItemCell {
        if let peopleItemCell = tableView.dequeueReusableCell(withIdentifier: "PeopleItemCell", for: indexPath) as? PeopleItemCell {
        let peopleItem = presenter?.getPeopleItemAt(indexpath: indexPath)
        peopleItemCell.configureCell(peopleItem: peopleItem)
         //To make the divider stretch from edge to edge
            peopleItemCell.layoutMargins = UIEdgeInsets.zero
            peopleItemCell.separatorInset = UIEdgeInsets.zero
        return peopleItemCell
      }
     return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexpath: indexPath)
	// Close keyboard when you select cell
        self.searchBar.searchTextField.endEditing(true)
        presenter?.deselectRowAt(indexpath: indexPath)
    }

func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    if let sections = presenter?.getSectionList() {
    return sections.map{$0.letter}
    }
    return nil
}

func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let sections = presenter?.getSectionList() {
    return sections[section].letter
    }
    return nil
}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 
	return UITableView.automaticDimension
	}
    
    
    
    
}

// MARK: - UI SearchBar
extension PeopleItemListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.handleSearch(isSearching: true, searchText: searchText)
	tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
	presenter?.handleSearch(isSearching: false, searchText: "")
	tableView.reloadData()
    }
}

// MARK: - UI Setup
extension PeopleItemListViewController {
    func setupUI() {
        tableView.addSubview(refreshControl)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44.0
        		tableView.rowHeight = UITableView.automaticDimension
        
        overrideUserInterfaceStyle = .light
        
        self.view.backgroundColor = .white
        FontUtility().setUpNavigationBar()
        let contactsTitle = NSLocalizedString("Contacts_Title", comment: "")
        self.navigationItem.title = contactsTitle
	self.searchBar.delegate = self
	self.searchBar.showsCancelButton = true

	let customBackButton = UIBarButtonItem(image: UIImage(named: "backArrow") , style: .plain, target: self, action: #selector(backAction(sender:)))
    customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
    navigationItem.leftBarButtonItem = customBackButton
    }

	func backAction(sender: UIBarButtonItem) {
    presenter?.popBack()
}
}
