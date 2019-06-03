import Cocoa

/*
    A customized NSTableView that overrides contextual menu behavior
 */
class AuralPlaylistTableView: NSTableView {
    
    // See extension below
    override func menu(for event: NSEvent) -> NSMenu? {
        return menuHandler(for: event)
    }
}

/*
    Custom view for a NSTableView row that displays a single playlist track. Customizes the selection look and feel.
 */
class AuralTableRowView: NSTableRowView {
    
    // Draws a fancy rounded rectangle around the selected track in the playlist view
    override func drawSelection(in dirtyRect: NSRect) {
        
        if self.selectionHighlightStyle != NSTableView.SelectionHighlightStyle.none {
            
            let selectionRect = self.bounds.insetBy(dx: 1, dy: 0)
            
            let selectionPath = NSBezierPath.init(roundedRect: selectionRect, xRadius: 2, yRadius: 2)
            Colors.playlistSelectionBoxColor.setFill()
            selectionPath.fill()
        }
    }
}

/*
    A customized NSOutlineView that overrides contextual menu behavior
 */
class AuralPlaylistOutlineView: NSOutlineView {
    
    // See extension below
    override func menu(for event: NSEvent) -> NSMenu? {
        return menuHandler(for: event)
    }
}

// Implements an event handler for customized contextual menu behavior
extension NSTableView {
    
    /*
        This function needs to be overriden in order to:
     
        1 - Only display the contextual menu when at least one row is available, and the click occurred within a playlist row view (i.e. not in empty table view space)
        2 - Capture the row for which the contextual menu was requested, and select it
        3 - Disable the row highlight displayed when presenting the contextual menu
     */
    func menuHandler(for event: NSEvent) -> NSMenu? {
        
        // If tableView has no rows, don't show the menu
        if (self.numberOfRows == 0) {
            return nil
        }
        
        // Calculate the clicked row
        let row = self.row(at: self.convert(event.locationInWindow, from: nil))
        
        // If the click occurred outside of any of the playlist rows (i.e. empty space), don't show the menu
        if (row == -1) {
            return nil
        }
        
        // Select the clicked row, implicitly clearing the previous selection
        self.selectRowIndexes(IndexSet(integer: row), byExtendingSelection: false)
        
        // Note that this view was clicked (this is required by the contextual menu)
        PlaylistViewContext.noteViewClicked(self)
        
        return self.menu
    }
}

class BasicFlatPlaylistCellView: NSTableCellView {
    
    // The table view row that this cell is contained in. Used to determine whether or not this cell is selected.
    var row: Int = -1
    
    // TODO: Store this logic in a closure passed in by the view delegate, instead of using TableViewHolder
    var isSelRow: Bool {
        return TableViewHolder.instance!.selectedRowIndexes.contains(row)
    }
    
    override var backgroundStyle: NSView.BackgroundStyle {
        
        didSet {
            backgroundStyleChanged()
        }
    }
    
    func backgroundStyleChanged() {
        
        // Check if this row is selected, change font and color accordingly
        if let textField = self.textField {
            
            textField.textColor = isSelRow ? Colors.playlistSelectedTextColor : Colors.playlistTextColor
            textField.font = isSelRow ? TextSizes.playlistSelectedTrackNameFont : TextSizes.playlistTrackNameFont
        }
    }
    
    func placeTextFieldOnTop() {
        
        let textField = self.textField!
        
        for con in self.constraints {
            
            if con.firstItem === textField && con.firstAttribute == .top {
                
                con.isActive = false
                self.removeConstraint(con)
                break
            }
        }
        
        var offset: CGFloat = 0
        
        switch TextSizes.playlistScheme {
            
        case .normal:   offset = -0.4
            
        case .larger:   offset = -0.6
            
        case .largest:  offset = 0
            
        }
        
        // textField.top == self.top
        let textFieldOnTopConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: offset)
        textFieldOnTopConstraint.isActive = true
        self.addConstraint(textFieldOnTopConstraint)
    }
    
    func placeTextFieldBelowView(_ view: NSView) {
        
        let textField = self.textField!
        
        for con in self.constraints {
            
            if con.firstItem === textField && con.firstAttribute == .top {
                
                con.isActive = false
                self.removeConstraint(con)
                break
            }
        }
        
        let textFieldBelowViewConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        textFieldBelowViewConstraint.isActive = true
        self.addConstraint(textFieldBelowViewConstraint)
    }
}

/*
 Custom view for a single NSTableView cell. Customizes the look and feel of cells (in selected rows) - font and text color.
 */
@IBDesignable
class TrackNameCellView: BasicFlatPlaylistCellView {
    
    @IBInspectable @IBOutlet weak var gapBeforeImg: NSImageView!
    @IBInspectable @IBOutlet weak var gapAfterImg: NSImageView!
}

/*
 Custom view for a single NSTableView cell. Customizes the look and feel of cells (in selected rows) - font and text color.
 */
@IBDesignable
class DurationCellView: BasicFlatPlaylistCellView {
    
    @IBInspectable @IBOutlet weak var gapBeforeTextField: NSTextField!
    @IBInspectable @IBOutlet weak var gapAfterTextField: NSTextField!
    
    override func backgroundStyleChanged() {
        
        // Check if this row is selected, change font and color accordingly
        if let textField = self.textField {
            
            textField.textColor = isSelRow ? Colors.playlistSelectedIndexTextColor : Colors.playlistIndexTextColor
            textField.font = TextSizes.playlistIndexFont
        }
    }
    
    override var backgroundStyle: NSView.BackgroundStyle {
        
        didSet {
            
            // Check if this row is selected
//            backgroundStyleChanged()
            
            if let gapField = self.gapBeforeTextField {
                
                gapField.textColor = isSelRow ? Colors.playlistSelectedGapTextColor : Colors.playlistGapTextColor
                gapField.font = isSelRow ? TextSizes.playlistSelectedTrackNameFont : TextSizes.playlistTrackNameFont
            }
            
            if let gapField = self.gapAfterTextField {
                
                gapField.textColor = isSelRow ? Colors.playlistSelectedGapTextColor : Colors.playlistGapTextColor
                gapField.font = isSelRow ? TextSizes.playlistSelectedTrackNameFont : TextSizes.playlistTrackNameFont
            }
        }
    }
    
    override func placeTextFieldOnTop() {
        
        let textField = self.textField!
        
        for con in self.constraints {
            
            if con.firstItem === textField && con.firstAttribute == .top {
                
                con.isActive = false
                self.removeConstraint(con)
                break
            }
        }
        
        var offset: CGFloat = 0
        
        switch TextSizes.playlistScheme {
            
        case .normal:   offset = 0
            
        case .larger:   offset = 0
            
        case .largest:  offset = -0.5
            
        }
        
        // textField.top == self.top
        let textFieldOnTopConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: offset)
        textFieldOnTopConstraint.isActive = true
        self.addConstraint(textFieldOnTopConstraint)
    }
    
    override func placeTextFieldBelowView(_ view: NSView) {
        
        let textField = self.textField!
        
        for con in self.constraints {
            
            if con.firstItem === textField && con.firstAttribute == .top {
                
                con.isActive = false
                self.removeConstraint(con)
                break
            }
        }
        
        let textFieldBelowViewConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 3)
        textFieldBelowViewConstraint.isActive = true
        self.addConstraint(textFieldBelowViewConstraint)
    }
}

/*
 Custom view for a single NSTableView cell. Customizes the look and feel of cells (in selected rows) - font and text color.
 */
class IndexCellView: BasicFlatPlaylistCellView {
    
    override func backgroundStyleChanged() {
        
        // Check if this row is selected, change font and color accordingly
        if let textField = self.textField {
            
            textField.textColor = isSelRow ? Colors.playlistSelectedIndexTextColor : Colors.playlistIndexTextColor
            textField.font = TextSizes.playlistIndexFont
        }
    }
    
    func adjustIndexConstraints_beforeGapOnly() {
        
        let textField = self.textField!
        let imgView = self.imageView!
        
        for con in self.constraints {
            
            if con.firstItem === textField && con.firstAttribute == .centerY {
                con.isActive = false
                self.removeConstraint(con)
            }
            
            if con.firstItem === imgView && con.firstAttribute == .centerY {
                con.isActive = false
                self.removeConstraint(con)
            }
        }
        
        let indexTF = NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -11)
        indexTF.isActive = true
        self.addConstraint(indexTF)
        
        let indexIV = NSLayoutConstraint(item: imgView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -12)
        indexIV.isActive = true
        self.addConstraint(indexIV)
    }
    
    func adjustIndexConstraints_afterGapOnly() {
        
        let textField = self.textField!
        let imgView = self.imageView!
        
        for con in self.constraints {
            
            if con.firstItem === textField && con.firstAttribute == .centerY {
                
                con.isActive = false
                self.removeConstraint(con)
            }
            
            if con.firstItem === imgView && con.firstAttribute == .centerY {
                
                con.isActive = false
                self.removeConstraint(con)
            }
        }
        
        let indexTF = NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -28)
        indexTF.isActive = true
        self.addConstraint(indexTF)
        
        let indexIV = NSLayoutConstraint(item: imgView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -30)
        indexIV.isActive = true
        self.addConstraint(indexIV)
    }
    
    func adjustIndexConstraints_centered() {
        
        let textField = self.textField!
        let imgView = self.imageView!
        
        for con in self.constraints {
            
            if con.firstItem === textField && con.firstAttribute == .centerY {
                
                con.isActive = false
                self.removeConstraint(con)
            }
            
            if con.firstItem === imageView && con.firstAttribute == .centerY {
                
                con.isActive = false
                self.removeConstraint(con)
            }
        }
        
        var offset: CGFloat = 0
        
        switch TextSizes.playlistScheme {
            
        case .normal:   offset = -0.8
            
        case .larger:   offset = -0.75
            
        case .largest:  offset = -1.5
            
        }
        
        let indexTF = NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: offset)
        indexTF.isActive = true
        self.addConstraint(indexTF)
        
        let indexIV = NSLayoutConstraint(item: imgView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -1)
        indexIV.isActive = true
        self.addConstraint(indexIV)
    }
}

///*
// Custom view for a single NSTableView cell. Customizes the look and feel of cells (in selected rows) - font and text color.
// */
//class GroupedTrackCellView: NSTableCellView {
//
//    // Whether or not this cell is contained within a row that represents a group (as opposed to a track)
//    var isGroup: Bool = false
//
//    // This is used to determine which NSOutlineView contains this cell
//    var playlistType: PlaylistType = .artists
//
//    // The item represented by the row containing this cell
//    var item: PlaylistItem?
//
//    // When the background changes (as a result of selection/deselection) switch to the appropriate colors/fonts
//    override var backgroundStyle: NSView.BackgroundStyle {
//
//        didSet {
//
//            // Check if this row is selected
//            let outlineView = OutlineViewHolder.instances[self.playlistType]!
//            let isSelRow = outlineView.selectedRowIndexes.contains(outlineView.row(forItem: item))
//
//            if let textField = self.textField {
//
//                textField.textColor = isSelRow ? (isGroup ? Colors.playlistGroupNameSelectedTextColor : Colors.playlistGroupItemSelectedTextColor) : (isGroup ? Colors.playlistGroupNameTextColor : Colors.playlistGroupItemTextColor)
//
//                textField.font = isSelRow ? (isGroup ? Fonts.playlistGroupNameSelectedTextFont : Fonts.playlistGroupItemSelectedTextFont) : (isGroup ? Fonts.playlistGroupNameTextFont : Fonts.playlistGroupItemTextFont)
//            }
//        }
//    }
//}

@IBDesignable
class GroupedTrackNameCellView: NSTableCellView {
    
    // The table view row that this cell is contained in. Used to determine whether or not this cell is selected.
    var row: Int = -1
    
    @IBInspectable @IBOutlet weak var gapBeforeImg: NSImageView!
    @IBInspectable @IBOutlet weak var gapAfterImg: NSImageView!
    
    // Whether or not this cell is contained within a row that represents a group (as opposed to a track)
    var isGroup: Bool = false
    
    // This is used to determine which NSOutlineView contains this cell
    var playlistType: PlaylistType = .artists
    
    // The item represented by the row containing this cell
    var item: PlaylistItem?
    
    // When the background changes (as a result of selection/deselection) switch to the appropriate colors/fonts
    override var backgroundStyle: NSView.BackgroundStyle {
        
        didSet {
            
            // Check if this row is selected
            let outlineView = OutlineViewHolder.instances[self.playlistType]!
            let isSelRow = outlineView.selectedRowIndexes.contains(outlineView.row(forItem: item))
            
            if let textField = self.textField {
                
                textField.textColor = isSelRow ? (isGroup ? Colors.playlistGroupNameSelectedTextColor : Colors.playlistGroupItemSelectedTextColor) : (isGroup ? Colors.playlistGroupNameTextColor : Colors.playlistGroupItemTextColor)
                
//                textField.font = isSelRow ? (isGroup ? Fonts.playlistGroupNameSelectedTextFont : Fonts.playlistGroupItemSelectedTextFont) : (isGroup ? Fonts.playlistGroupNameTextFont : Fonts.playlistGroupItemTextFont)
                
                textField.font = isSelRow ? (isGroup ? TextSizes.playlistSelectedGroupNameFont : TextSizes.playlistSelectedTrackNameFont) : (isGroup ? TextSizes.playlistGroupNameFont : TextSizes.playlistTrackNameFont)
            }
        }
    }
}

/*
 Custom view for a single NSTableView cell. Customizes the look and feel of cells (in selected rows) - font and text color.
 */
class GroupedTrackDurationCellView: NSTableCellView {
    
    // Whether or not this cell is contained within a row that represents a group (as opposed to a track)
    var isGroup: Bool = false
    
    // This is used to determine which NSOutlineView contains this cell
    var playlistType: PlaylistType = .artists
    
    // The item represented by the row containing this cell
    var item: PlaylistItem?
    
    @IBInspectable @IBOutlet weak var gapBeforeTextField: NSTextField!
    @IBInspectable @IBOutlet weak var gapAfterTextField: NSTextField!
    
    // When the background changes (as a result of selection/deselection) switch to the appropriate colors/fonts
    override var backgroundStyle: NSView.BackgroundStyle {
        
        didSet {
            
            // Check if this row is selected
            let outlineView = OutlineViewHolder.instances[self.playlistType]!
            let isSelRow = outlineView.selectedRowIndexes.contains(outlineView.row(forItem: item))
            
            if let textField = self.textField {
                
                textField.textColor = isSelRow ? (isGroup ? Colors.playlistGroupSelectedIndexTextColor : Colors.playlistSelectedIndexTextColor) : (isGroup ? Colors.playlistGroupIndexTextColor : Colors.playlistIndexTextColor)
                
                textField.font = isGroup ? TextSizes.playlistGroupDurationFont : TextSizes.playlistIndexFont
            }
            
            if !isGroup {
            
                if let gapField = self.gapBeforeTextField {
                    
                    gapField.textColor = isSelRow ? Colors.playlistSelectedGapTextColor : Colors.playlistGapTextColor
                    gapField.font = TextSizes.playlistIndexFont
                }
                
                if let gapField = self.gapAfterTextField {
                    
                    gapField.textColor = isSelRow ? Colors.playlistSelectedGapTextColor : Colors.playlistGapTextColor
                    gapField.font = TextSizes.playlistIndexFont
                }
                
            }
        }
    }
}

/*
 Custom view for a NSTableView row that displays a single playlist track or group. Customizes the selection look and feel.
 */
class GroupingPlaylistRowView: NSTableRowView {
    
    // Draws a fancy rounded rectangle around the selected track in the playlist view
    override func drawSelection(in dirtyRect: NSRect) {
        
        if self.selectionHighlightStyle != NSTableView.SelectionHighlightStyle.none {
            
            let selectionRect = self.bounds.insetBy(dx: 1, dy: 0)
            let selectionPath = NSBezierPath.init(roundedRect: selectionRect, xRadius: 2, yRadius: 2)
            
            Colors.playlistSelectionBoxColor.setFill()
            selectionPath.fill()
        }
    }
}

// Utility class to hold NSOutlineView instances for convenient access
class OutlineViewHolder {
    
    // Mapping of playlist types to their corresponding outline views
    static var instances = [PlaylistType: NSOutlineView]()
}

class BasicTableCellView: NSTableCellView {
    
    // The table view row that this cell is contained in. Used to determine whether or not this cell is selected.
    var row: Int = -1
    
    var selectionFunction: (() -> Bool) = {() -> Bool in return false}
    
    var textFont: NSFont = Fonts.gillSans10Font
    var selectedTextFont: NSFont = Fonts.gillSans10Font
    
    // TODO: Store this logic in a closure passed in by the view delegate, instead of using TableViewHolder
    var isSelRow: Bool {
        return selectionFunction()
    }
    
    override var backgroundStyle: NSView.BackgroundStyle {
        
        didSet {
            backgroundStyleChanged()
        }
    }
    
    func backgroundStyleChanged() {
        
        // Check if this row is selected, change font and color accordingly
        if let textField = self.textField {
            
            textField.textColor = isSelRow ? Colors.playlistSelectedTextColor : Colors.playlistTextColor
            textField.font = isSelRow ? selectedTextFont : textFont
        }
    }
}
