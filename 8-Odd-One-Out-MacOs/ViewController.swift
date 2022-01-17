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
    
    var images = ["elephant", "giraffe", "hippo", "monkey", "panda", "parrot", "penguin", "pig", "rabbit", "snake"]
    let currentLevel = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLevel()
        
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
    
    
    func generateLayout(items: Int) {
        // reset the game board
        for button in gridViewButtons {
            button.tag = 0
            button.image = nil
        }
        
        // randomize the buttons and animal images
        gridViewButtons.shuffle()
        images.shuffle()
        
        // create our two properties to place animals in pairs
        var numUsed = 0
        var itemCount = 1
        
        // create the odd animal by hand, giving it the tag 2, "correct answer"
        let firstButton = gridViewButtons[0]
        firstButton.tag = 2
        firstButton.image = NSImage(named: images[0])
        // now create all the rest of the animals
        for i in 1 ..< items {
            
            // pull out the button at this location and give it the tag 1, "wrong answer"
            let currentButton = gridViewButtons[i]
            currentButton.tag = 1
            
            // set its image to be the current animal
            currentButton.image = NSImage(named: images[itemCount])
            
            // mark that we've placed another animal in this pair
            numUsed += 1
            
            // if we have placed two animals of this type
            if (numUsed == 2) {
                // reset the counter
                numUsed = 0
                
                // place the next animal type
                itemCount += 1
            }
            // if we've reached the end of the animal types
            if (itemCount == images.count) {
                // go back to the start – 1, not 0, because we don't want to place the odd animal
                itemCount = 1
            }
        }
    }
    
    func createLevel() {
        switch currentLevel {
        case 1:
            generateLayout(items: 5)
        default:
            gameOver()
        }
    }
    
    func gameOver() {
    }
    
}

