//
//  ViewController.swift
//  8-Odd-One-Out-MacOs
//
//  Created by Baris Karalar on 14.01.2022.
//

import Cocoa

class ViewController: NSViewController {
    
    var visualEffectView: NSVisualEffectView!
    var gridViewButtons = [NSButton]()
    let gridSize = 10
    let gridMargin: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func loadView() {
        super.loadView()
        
        visualEffectView = NSVisualEffectView()
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        visualEffectView.state = .active
        view.addSubview(visualEffectView)
        
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let title = createTitle()
        createGridView(relativeTo: title)
        
    }
    
    func createTitle() -> NSTextField {
        
        let title = NSTextField(labelWithString: "Odd One Out")
        title.font = NSFont.systemFont(ofSize: 36, weight: .thin)
        title.textColor = NSColor.white
        title.translatesAutoresizingMaskIntoConstraints = false
        
        visualEffectView.addSubview(title)
        
        title.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: gridMargin).isActive = true
        title.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor).isActive = true
        
        return title
        
    }
    
    func createButtonArray() -> [[NSButton]] {
        var rows = [[NSButton]]()
        
        for _ in 0 ..< gridSize {
            var row = [NSButton]()
            
            for _ in 0 ..< gridSize {
                let button = createButton()
                
                gridViewButtons.append(button)
                row.append(button)
            }
            
            rows.append(row)
           
        }
    
        return rows
    }
    
    
    func createButton() -> NSButton {
        let button = NSButton(frame: NSRect(x: 0, y: 0, width: 64, height: 64))
        button.image = NSImage(named: "penguin")
        button.setButtonType(.momentaryChange)
        button.imagePosition = .imageOnly
        button.focusRingType = .none
        button.isBordered = false
        
//        button.action = #selector(imageClicked)
        button.target = self
        
        return button
    }
    
    func createGridView(relativeTo title: NSTextField) {
        let rows = createButtonArray()
        let gridView = NSGridView(views: rows)
        
        gridView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.addSubview(gridView)
        
        gridView.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor, constant: gridMargin).isActive = true
        gridView.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -gridMargin).isActive = true
        
        gridView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: gridMargin).isActive = true
        gridView.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -gridMargin).isActive = true
        
        gridView.columnSpacing = gridMargin / 2
        gridView.rowSpacing = gridMargin / 2
        
        for i in 0 ..< gridSize {
            gridView.row(at: i).height = 64
            gridView.column(at: i).width = 64
        }
        
    }
    
}

