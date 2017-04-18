//
//  CommentsViewController.swift
//  HNReader
//
//  Created by Alfonz Montelibano on 2/5/17.
//  Copyright © 2017 alphonsus. All rights reserved.
//

import UIKit
import RATreeView

class CommentsViewController: UIViewController, RATreeViewDelegate, RATreeViewDataSource {
	var treeView: RATreeView!
	var comments: [Comment] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupTreeView()

		// expand all comments by default
		for item in comments {
			treeView.expandRow(forItem: item, expandChildren: true, with: RATreeViewRowAnimationNone)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
	}
	
	func setupTreeView() -> Void {
		treeView = RATreeView(frame: view.bounds)
		treeView.register(UINib(nibName: String(describing: CommentTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CommentTableViewCell.self))
		treeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		treeView.delegate = self;
		treeView.dataSource = self;
		treeView.rowsExpandingAnimation = RATreeViewRowAnimationNone
		treeView.treeFooterView = UIView()
		treeView.backgroundColor = .clear
		treeView.expandsChildRowsWhenRowExpands = true
		view.addSubview(treeView)
	}
	
	//MARK: RATreeView data source
	
	func treeView(_ treeView: RATreeView, numberOfChildrenOfItem item: Any?) -> Int {
		if let item = item as? Comment {
			return item.children.count
		} else {
			return self.comments.count
		}
	}
	
	func treeView(_ treeView: RATreeView, child index: Int, ofItem item: Any?) -> Any {
		if let item = item as? Comment {
			return item.children[index]
		} else {
			return comments[index] as AnyObject
		}
	}
	
	func treeView(_ treeView: RATreeView, cellForItem item: Any?) -> UITableViewCell {
		let cell = treeView.dequeueReusableCell(withIdentifier: String(describing: CommentTableViewCell.self)) as! CommentTableViewCell
		let item = item as! Comment
		
		cell.selectionStyle = .none
		let detailsText = "Number of children \(item.children.count)"
		let level = treeView.levelForCell(forItem: item)
		print("\n---\n")
		print(item.text + " :::: \(level)")
		cell.setup(text: item.text, detailsText: detailsText, level: level)
		//		treeView.expandRow(forItem: item)
		//		cell.additionButtonActionBlock = { [weak treeView] cell in
		//			guard let treeView = treeView else {
		//				return;
		//			}
		//			let item = treeView.item(for: cell) as! DataObject
		//			let newItem = DataObject(name: "Added value")
		//			item.addChild(newItem)
		//			treeView.insertItems(at: IndexSet(integer: item.children.count-1), inParent: item, with: RATreeViewRowAnimationNone);
		//			treeView.reloadRows(forItems: [item], with: RATreeViewRowAnimationNone)
		//		}
		return cell
	}
	
	//MARK: RATreeView delegate
	
	func treeView(_ treeView: RATreeView, commit editingStyle: UITableViewCellEditingStyle, forRowForItem item: Any) {
		guard editingStyle == .delete else { return; }
		let item = item as! Comment
		let parent = treeView.parent(forItem: item) as? Comment
		
		let index: Int
		if let parent = parent {
			index = parent.children.index(where: { dataObject in
				return dataObject === item
			})!
			parent.removeChild(item)
			
		} else {
			index = self.comments.index(where: { dataObject in
				return dataObject === item;
			})!
			self.comments.remove(at: index)
		}
		
		self.treeView.deleteItems(at: IndexSet(integer: index), inParent: parent, with: RATreeViewRowAnimationRight)
		if let parent = parent {
			self.treeView.reloadRows(forItems: [parent], with: RATreeViewRowAnimationNone)
		}
	}}
