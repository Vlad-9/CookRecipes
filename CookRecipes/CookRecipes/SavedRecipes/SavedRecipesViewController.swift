//
//  SavedRecipesViewController.swift
//  CookRecipes
//
//  Created by Влад on 18.06.2022.
//

import UIKit
import SnapKit

class SavedRecipesViewController: UIViewController {

    private enum Constant {

    }
    
    // MARK: - Constraint

    private enum Constraint {
        static let titleTopOffset = 20
        static let titleLeadingTrailingInset = 20
        static let tableViewTopOffset = 15
    }

    // MARK: - Dependencies

    var presenter: ISavedRecipesPresenter

    // MARK: - UI Elements

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SavedRecipeTableViewCell.self,
                           forCellReuseIdentifier: SavedRecipeTableViewCell.tableViewReuseCellId)
        return tableView
    }()

    private lazy var titleLabel = CustomLabelBuilder()
        .setFont(AppFonts.bold24.font)
        .setTextColor(.label)
        .setTextAlignment(.left)
        .setNumberOfLines(0)
        .buildLabel()
    
    // MARK: - Initializer

    init(presenter: ISavedRecipesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupLayout()
    }
    func handleContentChange() {
        self.tableView.reloadData()
    }
}

// MARK: - Private

private extension SavedRecipesViewController {
    func configureView() {
        self.navigationController?.navigationBar.tintColor = Colors.primary50.value
        self.view.backgroundColor = .systemBackground
        titleLabel.text = "Saved recipes"
    }

    // MARK: - Layout

    func setupLayout() {
        setupTitleLayout()
        setupTableViewLayout()
    }

    func setupTitleLayout() {
        self.view?.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)//.offset(Constraint.titleTopOffset)
            make.leading.trailing.equalToSuperview().inset(Constraint.titleLeadingTrailingInset)
        }
    }

    func setupTableViewLayout() {
        self.view?.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constraint.tableViewTopOffset)
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - TableviewDelegate/Datasource

extension SavedRecipesViewController: UITableViewDelegate,
                                      UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter.getRecipesCount()
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedRecipeTableViewCell.tableViewReuseCellId, for: indexPath) as? SavedRecipeTableViewCell, let  model = presenter.getRecipeInfo(at: indexPath) else {
            return UITableViewCell()
        }

        cell.configureWith(model: model)
        return cell

    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.presenter.openRecipeDetails(at: indexPath)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.presenter.deleteRecipe(at: indexPath)
            completionHandler(true)
        }
        deleteAction.image = UIImage(named: "trashfi")
        deleteAction.backgroundColor = .systemBackground
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

// MARK: - IDataManagerDelegate

extension SavedRecipesViewController: IDataManagerDelegate {
    func contentChangedHandler() {
        self.tableView.reloadData()
    }
}
