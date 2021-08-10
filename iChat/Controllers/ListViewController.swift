//
//  ListViewController.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 09.08.2021.
//

import UIKit

class ListViewController: UIViewController {
    
    let activeChats = Bundle.main.decode([MChat].self, from: "activeChats.json")
    let waitingChats = Bundle.main.decode([MChat].self, from: "waitingChats.json")
    
    enum Section: Int, CaseIterable {
        case  waitingChats, activeChats
        
        func headerDescription() -> String {
            switch self {
            case .waitingChats:
                return "Waiting chats"
            case .activeChats:
                return "Active chats"
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MChat>?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    //MARK: Setup Search Controller
    private func setupSearchController() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self 
    }
    
    //MARK: Setup Collection View
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        collectionView.register(ActiveChatsCell.self, forCellWithReuseIdentifier: ActiveChatsCell.resudeId)
        collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.resudeId)
        
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MChat>()
        
        snapshot.appendSections([.waitingChats, .activeChats])
        
        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        snapshot.appendItems(activeChats, toSection: .activeChats)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Data Source
extension ListViewController {
    
    
    private func configure<Cell: SelfConfigureCell>(cellType: Cell.Type, with value: MChat, indexPath: IndexPath) -> Cell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.resudeId, for: indexPath) as? Cell else { fatalError() }
        
        cell.configure(with: value)
        return cell
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .activeChats:
                return self.configure(cellType: ActiveChatsCell.self, with: chat, indexPath: indexPath)
            case .waitingChats:
                return self.configure(cellType: WaitingChatCell.self, with: chat, indexPath: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError() }
            
            guard let section = Section(rawValue: indexPath.section) else { fatalError() }
            
            sectionHeader.configure(text: section.headerDescription(), font: .laoSangamMN20(), textColor: #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 1))
            
            return sectionHeader
        }
    }
}

// MARK: - Setup layout
extension ListViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .activeChats:
                return self.createActiveChats()
            case .waitingChats:
                return self.createWaitingChats()
            }
        }
        let configure = UICollectionViewCompositionalLayoutConfiguration()
        configure.interSectionSpacing = 20
        layout.configuration = configure
        return layout
    }
    
    private func createWaitingChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88),
                                               heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [createSectionHeader()]
        return section
    }
    
    private func createActiveChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        
        section.boundarySupplementaryItems = [createSectionHeader()]
        
        return section
    }
}

private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: sectionHeaderSize,
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .top)
    
    return sectionHeader
}

//MARK: Search bar delegate
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

//MARK: Setup Canvas
import SwiftUI

struct ListViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            MainTabBarController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
