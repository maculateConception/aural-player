import Cocoa

class PlayQueueViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, NotificationSubscriber {
    
    @IBOutlet weak var playQueueView: NSTableView!
    
    private let playlist: PlaylistDelegateProtocol = ObjectGraph.playlistDelegate
    
    // Used to determine the currently playing track
    private let playbackInfo: PlaybackInfoDelegateProtocol = ObjectGraph.playbackInfoDelegate
    
    private var cachedGapImage: NSImage!
    
    override var nibName: String? {return "PlayQueue"}
    
    override func awakeFromNib() {
        cachedGapImage = Images.imgGap.applyingTint(Colors.Playlist.trackNameTextColor)
    }
    
    override func viewDidLoad() {
        
        Messenger.subscribeAsync(self, .playlist_trackAdded, self.trackAdded(_:), queue: .main)
        
        let title_desc = NSSortDescriptor(key: "title", ascending: true)
        let duration_desc = NSSortDescriptor(key: "duration", ascending: true)
        let artist_desc = NSSortDescriptor(key: "artist", ascending: true)
        
        playQueueView.tableColumns[1].sortDescriptorPrototype = title_desc
        playQueueView.tableColumns[2].sortDescriptorPrototype = duration_desc
        playQueueView.tableColumns[3].sortDescriptorPrototype = artist_desc
    }
    
    func trackAdded(_ notification: TrackAddedNotification) {
        self.playQueueView.insertRows(at: IndexSet(integer: notification.trackIndex), withAnimation: .slideDown)
    }
    
    func changeGapIndicatorColor(_ color: NSColor) {
        cachedGapImage = Images.imgGap.applyingTint(Colors.Playlist.trackNameTextColor)
    }
    
    // Returns the total number of playlist rows
    func numberOfRows(in tableView: NSTableView) -> Int {
        return playlist.size
    }
    
    // Returns a view for a single row
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return PlaylistRowView()
    }
    
    // Enables type selection, allowing the user to conveniently and efficiently find a playlist track by typing its display name, which results in the track, if found, being selected within the playlist
    func tableView(_ tableView: NSTableView, typeSelectStringFor tableColumn: NSTableColumn?, row: Int) -> String? {
        
        // Only the track name column is used for type selection
        return tableColumn?.identifier == .playQueue_title ? playlist.trackAtIndex(row)?.conciseDisplayName : nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        
        if let track = playlist.trackAtIndex(row) {
            
            let gapBeforeTrack = playlist.getGapBeforeTrack(track) != nil
            let gapAfterTrack = playlist.getGapAfterTrack(track) != nil
            
            if gapAfterTrack && gapBeforeTrack {
                return 61
                
            } else if gapAfterTrack || gapBeforeTrack {
                return 43
            }
        }

        return 25
    }
    
    // Returns a view for a single column
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let track = playlist.trackAtIndex(row), let columnId = tableColumn?.identifier else {return nil}
            
        let gapBeforeTrack = playlist.getGapBeforeTrack(track)
        let gapAfterTrack = playlist.getGapAfterTrack(track)
        
        switch columnId {
            
        case .playQueue_index:
            
            let indexText: String = String(row + 1)
            
            // Check if there is a track currently playing, and if this row matches that track.
            if let currentTrack = playbackInfo.currentTrack, currentTrack == track {
                
                var image: NSImage!
                
                switch playbackInfo.state {
                    
                case .playing, .paused:
                    
                    image = Images.imgPlayingTrack
                    
                case .waiting:
                    
                    image = Images.imgWaitingTrack
                    
                case .transcoding:
                    
                    image = Images.imgTranscodingTrack
                
                default: return nil // Impossible
                
                }
                
                return createIndexImageCell(tableView, gapBeforeTrack, gapAfterTrack, row, image.applyingTint(Colors.Playlist.playingTrackIconColor))
            }
            
            // Otherwise, create a text cell with the track index
            return createIndexTextCell(tableView, indexText, gapBeforeTrack, gapAfterTrack, row)
            
        case .playQueue_title:
            
            return createTextCell(tableView, .playQueue_title, track.displayInfo.title, gapBeforeTrack, gapAfterTrack, row)
            
        case .playQueue_duration:
            
            return createDurationCell(tableView, ValueFormatter.formatSecondsToHMS(track.duration), gapBeforeTrack, gapAfterTrack, row)
            
        case .playQueue_artist:
            
            if let artist = track.groupingInfo.artist {
                return createTextCell(tableView, .playQueue_artist, artist, gapBeforeTrack, gapAfterTrack, row)
            }
            
            return nil
            
        case .playQueue_album:
            
            if let album = track.groupingInfo.album {
                return createTextCell(tableView, .playQueue_album, album, gapBeforeTrack, gapAfterTrack, row)
            }
            
            return nil
            
        case .playQueue_genre:
            
            if let genre = track.groupingInfo.genre {
                return createTextCell(tableView, .playQueue_genre, genre, gapBeforeTrack, gapAfterTrack, row)
            }
            
            return nil
            
        default: return nil // Impossible
            
        }
    }
    
    private func createIndexTextCell(_ tableView: NSTableView, _ text: String, _ gapBefore: PlaybackGap? = nil, _ gapAfter: PlaybackGap? = nil, _ row: Int) -> IndexCellView? {
     
        guard let cell = tableView.makeView(withIdentifier: .playQueue_index, owner: nil) as? IndexCellView else {return nil}
        
        cell.rowSelectionStateFunction = {tableView.selectedRowIndexes.contains(row)}
        
        cell.updateText(Fonts.Playlist.indexFont, text)
//        cell.updateForGaps(gapBefore != nil, gapAfter != nil)
        
        return cell
    }
    
    private func createIndexImageCell(_ tableView: NSTableView, _ gapBefore: PlaybackGap? = nil, _ gapAfter: PlaybackGap? = nil, _ row: Int, _ image: NSImage) -> IndexCellView? {
        
        guard let cell = tableView.makeView(withIdentifier: .playQueue_index, owner: nil) as? IndexCellView else {return nil}
            
        cell.rowSelectionStateFunction = {tableView.selectedRowIndexes.contains(row)}
        
        cell.updateImage(image)
//        cell.updateForGaps(gapBefore != nil, gapAfter != nil)
        
        return cell
    }
    
    private func createTextCell(_ tableView: NSTableView, _ id: NSUserInterfaceItemIdentifier, _ text: String, _ gapBefore: PlaybackGap? = nil, _ gapAfter: PlaybackGap? = nil, _ row: Int) -> TextCellView? {
        
        guard let cell = tableView.makeView(withIdentifier: id, owner: nil) as? TextCellView else {return nil}
            
        cell.rowSelectionStateFunction = {tableView.selectedRowIndexes.contains(row)}
        
        cell.updateText(Fonts.Playlist.trackNameFont, text)
        
        cell.gapImage = cachedGapImage
//        cell.updateForGaps(gapBefore != nil, gapAfter != nil)
        
        return cell
    }
    
    private func createDurationCell(_ tableView: NSTableView, _ text: String, _ gapBefore: PlaybackGap? = nil, _ gapAfter: PlaybackGap? = nil, _ row: Int) -> DurationCellView? {
        
        guard let cell = tableView.makeView(withIdentifier: .playQueue_duration, owner: nil) as? DurationCellView else {return nil}
        
        cell.rowSelectionStateFunction = {tableView.selectedRowIndexes.contains(row)}
        
        cell.updateText(Fonts.Playlist.indexFont, text)
//        cell.updateForGaps(gapBefore != nil, gapAfter != nil, gapBefore?.duration, gapAfter?.duration)
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        
        guard let sortDescriptor = tableView.sortDescriptors.first, let key = sortDescriptor.key else {return}
        let ascending = sortDescriptor.ascending
        
        let tracksSort: TracksSort = TracksSort()
        let sort: Sort = Sort().withTracksSort(tracksSort)
        
        switch key {
            
        case "title":
            
            _ = tracksSort.withFields(.title)
            
        case "duration":
            
            _ = tracksSort.withFields(.duration)
            
        case "artist":
            
            _ = tracksSort.withFields(.artist, .album, .discNumberAndTrackNumber)
            
        case "album":
            
            _ = tracksSort.withFields(.album, .discNumberAndTrackNumber)
            
        case "genre":
            
            _ = tracksSort.withFields(.genre)
            
        default: return
            
        }
        
        _ = tracksSort.withOrder(ascending ? .ascending : .descending).withNoOptions()

        playlist.sort(sort, .tracks)
        tableView.reloadData()
    }
}
