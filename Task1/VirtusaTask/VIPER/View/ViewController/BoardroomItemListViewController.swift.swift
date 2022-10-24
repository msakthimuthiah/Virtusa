
import UIKit
import PKHUD

class BoardroomItemListViewController: UIViewController {


    // MARK: - Properties
    var presenter: ViewToPresenterBoardroomItemListProtocol?
    
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

extension BoardroomItemListViewController: PresenterToViewBoardroomItemListProtocol{
    
    func onFetchBoardroomItemListSuccess() {
        print("View receives the response from Presenter and updates itself.")
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchBoardroomItemListFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        self.refreshControl.endRefreshing()
    }
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
    
}

// MARK: - UITableView Delegate & Data Source
extension BoardroomItemListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return presenter?.numberOfSections() ?? 0  
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> BoardroomItemCell {
        if let boardroomItemCell = tableView.dequeueReusableCell(withIdentifier: "BoardroomItemCell", for: indexPath) as? BoardroomItemCell {
        let boardroomItem = presenter?.getBoardroomItemAt(indexpath: indexPath)
        boardroomItemCell.configureCell(boardroomItem: boardroomItem)
        //To make the divider stretch from edge to edge
            boardroomItemCell.layoutMargins = UIEdgeInsets.zero
            boardroomItemCell.separatorInset = UIEdgeInsets.zero
        return boardroomItemCell
      }
     return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexpath: indexPath)
	// Close keyboard when you select cell
        self.searchBar.searchTextField.endEditing(true)
        presenter?.deselectRowAt(indexpath: indexPath)
    }

func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let sections = presenter?.getSectionList() {
    return sections[section].availability
    }
    return nil
}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 
	return UITableView.automaticDimension
	}
    
    
    
    
}

// MARK: - UI SearchBar
extension BoardroomItemListViewController: UISearchBarDelegate {
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
extension BoardroomItemListViewController {
    func setupUI() {
        tableView.addSubview(refreshControl)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44.0
        		tableView.rowHeight = UITableView.automaticDimension
        
        overrideUserInterfaceStyle = .light
        
        self.view.backgroundColor = .white
        FontUtility().setUpNavigationBar()
        let boardroomsTitle = NSLocalizedString("Boardrooms_Title", comment: "")
        self.navigationItem.title = boardroomsTitle
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
