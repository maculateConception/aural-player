import Foundation
import AVFoundation

/*
    Specification for the iTunes metadata format.
 */
class ITunesSpec: MetadataSpec {
    
    // Mappings of format-specific keys to readable keys
    private static var mapByKey: [String: String] = initMapByKey()
    private static var mapByID: [String: String] = initMapByID()
    
    static func readableKey(_ key: String) -> String? {
        
        if let rKey = mapByKey[key] {
            return rKey
        }
        
        return ITunesLongFormSpec.readableKey(key)
    }
    
    static func readableKeyByID(_ id: String) -> String? {
        
        if let rKey = mapByID[id] {
            return rKey
        }
        
        return ITunesLongFormSpec.readableKeyByID(id)
    }
    
    private static func initMapByID() -> [String: String] {
        
        var map: [String: String] = [:]
        
        map[AVMetadataIdentifier.iTunesMetadataAlbum.rawValue] = "Album"
        
        map[AVMetadataIdentifier.iTunesMetadataArtist.rawValue] = "Artist"
        
        map[AVMetadataIdentifier.iTunesMetadataUserComment.rawValue] = "User Comment"
        
        map[AVMetadataIdentifier.iTunesMetadataCoverArt.rawValue] = "Cover Art"
        
        map[AVMetadataIdentifier.iTunesMetadataCopyright.rawValue] = "Copyright"
        
        map[AVMetadataIdentifier.iTunesMetadataReleaseDate.rawValue] = "Release Date"
        
        map[AVMetadataIdentifier.iTunesMetadataEncodedBy.rawValue] = "Encoded By"
        
        map[AVMetadataIdentifier.iTunesMetadataPredefinedGenre.rawValue] = "Predefined Genre"
        
        map[AVMetadataIdentifier.iTunesMetadataUserGenre.rawValue] = "User Genre"
        
        map[AVMetadataIdentifier.iTunesMetadataSongName.rawValue] = "Song Name"
        
        map[AVMetadataIdentifier.iTunesMetadataTrackSubTitle.rawValue] = "Track Sub Title"
        
        map[AVMetadataIdentifier.iTunesMetadataEncodingTool.rawValue] = "Encoding Tool"
        
        map[AVMetadataIdentifier.iTunesMetadataComposer.rawValue] = "Composer"
        
        map[AVMetadataIdentifier.iTunesMetadataAlbumArtist.rawValue] = "Album Artist"
        
        map[AVMetadataIdentifier.iTunesMetadataAccountKind.rawValue] = "Account Kind"
        
        map[AVMetadataIdentifier.iTunesMetadataAppleID.rawValue] = "Apple ID"
        
        map[AVMetadataIdentifier.iTunesMetadataArtistID.rawValue] = "Artist ID"
        
        map[AVMetadataIdentifier.iTunesMetadataSongID.rawValue] = "Song ID"
        
        map[AVMetadataIdentifier.iTunesMetadataDiscCompilation.rawValue] = "Disc Compilation"
        
        map[AVMetadataIdentifier.iTunesMetadataDiscNumber.rawValue] = "Disc Number"
        
        map[AVMetadataIdentifier.iTunesMetadataGenreID.rawValue] = "Genre ID"
        
        map[AVMetadataIdentifier.iTunesMetadataGrouping.rawValue] = "Grouping"
        
        map[AVMetadataIdentifier.iTunesMetadataPlaylistID.rawValue] = "Playlist ID"
        
        map[AVMetadataIdentifier.iTunesMetadataContentRating.rawValue] = "Content Rating"
        
        map[AVMetadataIdentifier.iTunesMetadataBeatsPerMin.rawValue] = "Beats Per Min"
        
        map[AVMetadataIdentifier.iTunesMetadataTrackNumber.rawValue] = "Track Number"
        
        map[AVMetadataIdentifier.iTunesMetadataArtDirector.rawValue] = "Art Director"
        
        map[AVMetadataIdentifier.iTunesMetadataArranger.rawValue] = "Arranger"
        
        map[AVMetadataIdentifier.iTunesMetadataAuthor.rawValue] = "Author"
        
        map[AVMetadataIdentifier.iTunesMetadataLyrics.rawValue] = "Lyrics"
        
        map[AVMetadataIdentifier.iTunesMetadataAcknowledgement.rawValue] = "Acknowledgement"
        
        map[AVMetadataIdentifier.iTunesMetadataConductor.rawValue] = "Conductor"
        
        map[AVMetadataIdentifier.iTunesMetadataDescription.rawValue] = "Description"
        
        map[AVMetadataIdentifier.iTunesMetadataDirector.rawValue] = "Director"
        
        map[AVMetadataIdentifier.iTunesMetadataEQ.rawValue] = "EQ"
        
        map[AVMetadataIdentifier.iTunesMetadataLinerNotes.rawValue] = "Liner Notes"
        
        map[AVMetadataIdentifier.iTunesMetadataRecordCompany.rawValue] = "Record Company"
        
        map[AVMetadataIdentifier.iTunesMetadataOriginalArtist.rawValue] = "Original Artist"
        
        map[AVMetadataIdentifier.iTunesMetadataPhonogramRights.rawValue] = "Phonogram Rights"
        
        map[AVMetadataIdentifier.iTunesMetadataProducer.rawValue] = "Producer"
        
        map[AVMetadataIdentifier.iTunesMetadataPerformer.rawValue] = "Performer"
        
        map[AVMetadataIdentifier.iTunesMetadataPublisher.rawValue] = "Publisher"
        
        map[AVMetadataIdentifier.iTunesMetadataSoundEngineer.rawValue] = "Sound Engineer"
        
        map[AVMetadataIdentifier.iTunesMetadataSoloist.rawValue] = "Soloist"
        
        map[AVMetadataIdentifier.iTunesMetadataCredits.rawValue] = "Credits"
        
        map[AVMetadataIdentifier.iTunesMetadataThanks.rawValue] = "Thanks"
        
        map[AVMetadataIdentifier.iTunesMetadataOnlineExtras.rawValue] = "Online Extras"
        
        map[AVMetadataIdentifier.iTunesMetadataExecProducer.rawValue] = "Exec Producer"
        
        return map
    }
    
    private static func initMapByKey() -> [String: String] {
        
        var map: [String: String] = [String: String]()
        
        // @alb
        map[AVMetadataKey.iTunesMetadataKeyAlbum.rawValue] = "Album"
        
        // @ART
        map[AVMetadataKey.iTunesMetadataKeyArtist.rawValue] = "Artist"
        
        // @cmt
        map[AVMetadataKey.iTunesMetadataKeyUserComment.rawValue] = "User Comment"
        
        // covr
        map[AVMetadataKey.iTunesMetadataKeyCoverArt.rawValue] = "Cover Art"
        
        // cprt
        map[AVMetadataKey.iTunesMetadataKeyCopyright.rawValue] = "Copyright"
        
        // @day
        map[AVMetadataKey.iTunesMetadataKeyReleaseDate.rawValue] = "Release Date"
        
        // @enc
        map[AVMetadataKey.iTunesMetadataKeyEncodedBy.rawValue] = "Encoded By"
        
        // gnre
        map[AVMetadataKey.iTunesMetadataKeyPredefinedGenre.rawValue] = "Predefined Genre"
        
        // @gen
        map[AVMetadataKey.iTunesMetadataKeyUserGenre.rawValue] = "User Genre"
        
        // @nam
        map[AVMetadataKey.iTunesMetadataKeySongName.rawValue] = "Song Name"
        
        // @st3
        map[AVMetadataKey.iTunesMetadataKeyTrackSubTitle.rawValue] = "Track Sub Title"
        
        // @too
        map[AVMetadataKey.iTunesMetadataKeyEncodingTool.rawValue] = "Encoding Tool"
        
        // @wrt
        map[AVMetadataKey.iTunesMetadataKeyComposer.rawValue] = "Composer"
        
        // aART
        map[AVMetadataKey.iTunesMetadataKeyAlbumArtist.rawValue] = "Album Artist"
        
        // akID
        map[AVMetadataKey.iTunesMetadataKeyAccountKind.rawValue] = "Account Kind"
        
        // apID
        map[AVMetadataKey.iTunesMetadataKeyAppleID.rawValue] = "Apple ID"
        
        // atID
        map[AVMetadataKey.iTunesMetadataKeyArtistID.rawValue] = "Artist ID"
        
        // cnID
        map[AVMetadataKey.iTunesMetadataKeySongID.rawValue] = "Song ID"
        
        // cpil
        map[AVMetadataKey.iTunesMetadataKeyDiscCompilation.rawValue] = "Disc Compilation"
        
        // disk
        map[AVMetadataKey.iTunesMetadataKeyDiscNumber.rawValue] = "Disc Number"
        
        // geID
        map[AVMetadataKey.iTunesMetadataKeyGenreID.rawValue] = "Genre ID"
        
        // grup
        map[AVMetadataKey.iTunesMetadataKeyGrouping.rawValue] = "Grouping"
        
        // plID
        map[AVMetadataKey.iTunesMetadataKeyPlaylistID.rawValue] = "Playlist ID"
        
        // rtng
        map[AVMetadataKey.iTunesMetadataKeyContentRating.rawValue] = "Content Rating"
        
        // tmpo
        map[AVMetadataKey.iTunesMetadataKeyBeatsPerMin.rawValue] = "Beats Per Min"
        
        // trkn
        map[AVMetadataKey.iTunesMetadataKeyTrackNumber.rawValue] = "Track Number"
        
        // @ard
        map[AVMetadataKey.iTunesMetadataKeyArtDirector.rawValue] = "Art Director"
        
        // @arg
        map[AVMetadataKey.iTunesMetadataKeyArranger.rawValue] = "Arranger"
        
        // @aut
        map[AVMetadataKey.iTunesMetadataKeyAuthor.rawValue] = "Author"
        
        // @lyr
        map[AVMetadataKey.iTunesMetadataKeyLyrics.rawValue] = "Lyrics"
        
        // @cak
        map[AVMetadataKey.iTunesMetadataKeyAcknowledgement.rawValue] = "Acknowledgement"
        
        // @con
        map[AVMetadataKey.iTunesMetadataKeyConductor.rawValue] = "Conductor"
        
        // @des
        map[AVMetadataKey.iTunesMetadataKeyDescription.rawValue] = "Description"
        
        // @dir
        map[AVMetadataKey.iTunesMetadataKeyDirector.rawValue] = "Director"
        
        // @equ
        map[AVMetadataKey.iTunesMetadataKeyEQ.rawValue] = "EQ"
        
        // @lnt
        map[AVMetadataKey.iTunesMetadataKeyLinerNotes.rawValue] = "Liner Notes"
        
        // @mak
        map[AVMetadataKey.iTunesMetadataKeyRecordCompany.rawValue] = "Record Company"
        
        // @ope
        map[AVMetadataKey.iTunesMetadataKeyOriginalArtist.rawValue] = "Original Artist"
        
        // @phg
        map[AVMetadataKey.iTunesMetadataKeyPhonogramRights.rawValue] = "Phonogram Rights"
        
        // @prd
        map[AVMetadataKey.iTunesMetadataKeyProducer.rawValue] = "Producer"
        
        // @prf
        map[AVMetadataKey.iTunesMetadataKeyPerformer.rawValue] = "Performer"
        
        // @pub
        map[AVMetadataKey.iTunesMetadataKeyPublisher.rawValue] = "Publisher"
        
        // @sne
        map[AVMetadataKey.iTunesMetadataKeySoundEngineer.rawValue] = "Sound Engineer"
        
        // @sol
        map[AVMetadataKey.iTunesMetadataKeySoloist.rawValue] = "Soloist"
        
        // @src
        map[AVMetadataKey.iTunesMetadataKeyCredits.rawValue] = "Credits"
        
        // @thx
        map[AVMetadataKey.iTunesMetadataKeyThanks.rawValue] = "Thanks"
        
        // @url
        map[AVMetadataKey.iTunesMetadataKeyOnlineExtras.rawValue] = "Online Extras"
        
        // @xpd
        map[AVMetadataKey.iTunesMetadataKeyExecProducer.rawValue] = "Exec Producer"
        
        return map
    }
}

class ITunesLongFormSpec: MetadataSpec {
    
    static let keySpaceID: String = "itlk"
    static let formatID: String = "org.mp4ra"
    
    // Mappings of format-specific keys to readable keys
    private static var mapByKey: [String: String] = initMapByKey()
    
    static func readableKey(_ key: String) -> String? {
        
        let trimmedKeyTokens = key.lowercased().replacingOccurrences(of: "com.apple.itunes", with: "|").split(separator: "|")
        
        if let trimmedKey = trimmedKeyTokens.last {
            return mapByKey[trimmedKey.trim().trimmingCharacters(in: CharacterSet(charactersIn: ":;."))]
        }
        
        return nil
    }
    
    static func readableKeyByID(_ id: String) -> String? {
        return readableKey(id)
    }
    
    private static func initMapByKey() -> [String: String] {
        
        var map: [String: String] = [:]
        
        map["itunsmpb"] = "Gapless Playback"
        map["itunnorm"] = "Sound Check"
        map["itunpgap"] = "Playlist Delay"
        map["encodingparams"] = "Encoding Parameters"

        map["itunes_cddb_ids"] = "CDDB IDs"
        map["itunes_cddb_1"] = "CDDB 1"
        map["itunes_cddb_tracknumber"] = "CDDB Track Number"

        map["accurateripdiscid"] = "AccurateRip Disc ID"
        map["accurateripresult"] = "AccurateRip Result"

        map["musicippuid"] = "MusicIP PUID"
        map["musicbrainzartistId"] = "MusicBrainz Artist ID"
        map["musicbrainzalbumartistId"] = "MusicBrainz Album Artist ID"
        map["musicbrainzalbumid"] = "MusicBrainz Album ID"
        map["musicbrainztrackid"] = "MusicBrainz Track ID"
        map["musicbrainzalbumreleasecountry"] = "MusicBrainz Album Release Country"
        map["musicbrainzalbumtype"] = "MusicBrainz Album Type"
        map["musicbrainzalbumstatus"] = "MusicBrainz Album Status"

        map["source"] = "Source"
        map["asin"] = "ASIN"
        map["tool"] = "Tool"
        map["upc"] = "UPC"
        
        map["acousticbrainz data"] = "AcousticBrainz Data"
        
        map["acoustid data"] = "Acoustid Data"
        
        map["acoustid fingerprint"] = "Acoustid Fingerprint"
        
        map["acoustid fingerprint fault"] = "Acoustid Fingerprint Fault"
        
        map["acoustid id"] = "Acoustid Id"
        
        map["acoustid status"] = "Acoustid Status"
        
        map["apiseeds artist"] = "APISEEDS Artist"
        
        map["apiseeds probability"] = "APISEEDS Probability"
        
        map["apiseeds status"] = "APISEEDS Status"
        
        map["apiseeds text"] = "APISEEDS Text"
        
        map["apiseeds title"] = "APISEEDS Title"
        
        map["autosearch_artwork_url"] = "Autosearch Artwork URL"
        
        map["barcode"] = "Barcode"
        
        map["beatport_album_url"] = "Beatport Album URL"
        
        map["beatport_artist_url"] = "Beatport Artist URLs"
        
        map["beatport import time"] = "Beatport Import Time"
        
        map["beatport_label_url"] = "Beatport Label URL"
        
        map["beatport release id"] = "Beatport Release Id"
        
        map["beatport track id"] = "Beatport Track Id"
        
        map["ufid"] = "Beatport Track Id"
        
        map["beatport_track_url"] = "Beatport Track URL"
        
        map["catalognumber"] = "Catalog Number"
        
        map["category"] = "Category"
        
        map["itunextc"] = "Classification"
        
        map["commercial_info_url"] = "Commercial Information Webpage"
        
        map["conductor"] = "Conductor"
        
        map["copyright url"] = "Copyright/Legal Information Webpage"
        
        map["country"] = "Country"
        
        map["cuesheet"] = "CUESHEET"
        
        map["user configurable"] = "Custom 0...99"
        
        map["discogs_albumartist_url"] = "Discogs Album Artist URLs"
        
        map["discogs_artist_list"] = "Discogs Artist List"
        
        map["discogs_anv_list"] = "Discogs Artist Name Variations"
        
        map["discogs_artist_url"] = "Discogs Artist URLs"
        
        map["discogs_artwork_url"] = "Discogs Artwork URL"
        
        map["discogs_catalog_number"] = "Discogs Catalog Number"
        
        map["discogs_import_settings"] = "Discogs Import Settings"
        
        map["discogs_exception_mask"] = "Discogs Exception Mask"
        
        map["discogs_import_time"] = "Discogs Import Time"
        
        map["discogs_label_url"] = "Discogs Label URLs"
        
        map["discogs_master_id"] = "Discogs Master Id"
        
        map["discogs_master_url"] = "Discogs Master URL"
        
        map["discogs album release country"] = "Discogs Release Country"
        
        map["discogs_release_id"] = "Discogs Release Id"
        
        map["discogs release notes"] = "Discogs Release Notes"
        
        map["discogs release ordinal position"] = "Discogs Release Ordinal Position"
        
        map["discogs_release_url"] = "Discogs Release URL"
        
        map["encoding"] = "Encoder Settings"
        
        map["encodingtime"] = "Encoding Time"
        
        map["filetype"] = "File Type"
        
        map["imdb id"] = "IMDB ID"
        
        map["key"] = "Initial Key"
        
        map["involvedpeople"] = "Involved People"
        
        map["djmixer"] = "DJ Mixer"
        
        map["engineer"] = "Engineer"
        
        map["mixer"] = "Mixer"
        
        map["producer"] = "Producer"
        
        map["instrumental"] = "Instrumental"
        
        map["isrc"] = "ISRC"
        
        map["itunes pid"] = "iTunes PID"
        
        map["label"] = "Label"
        
        map["language"] = "Language"
        
        map["length"] = "Length (ms)"
        
        map["love-dislike rating"] = "Love"
        
        map["lyricist"] = "Lyricist"
        
        map["lyricwiki takedown status"] = "LyricWiki Takedown Status id"
        
        map["lyricwiki url"] = "LyricWiki URL"
        
        map["media"] = "Media Type"
        
        map["mood"] = "Mood"
        
        map["music_cd_identifier"] = "Music CD Identifier"
        
        map["musicbrainz album artist id"] = "MusicBrainz Album Artist Id"
        
        map["musicbrainz_albumartist_url"] = "MusicBrainz Album Artist URLs"
        
        map["musicbrainz artist id"] = "MusicBrainz Artist Id"
        
        map["musicbrainz_artist_url"] = "MusicBrainz Artist URLs"
        
        map["musicbrainz_artwork_url_type"] = "MusicBrainz Artwork URLs"
        
        map["musicbrainz_catalog_number"] = "MusicBrainz Catalog Number"
        
        map["musicbrainz disc id"] = "MusicBrainz Disc Id"
        
        map["musicbrainz_exception_mask"] = "MusicBrainz Exception Mask"
        
        map["musicbrainz_import_settings"] = "MusicBrainz Import Settings"
        
        map["musicbrainz_import_time"] = "MusicBrainz Import Time"
        
        map["musicbrainz_label_url"] = "MusicBrainz label URLs"
        
        map["musicbrainz original album id"] = "MusicBrainz Original Album Id"
        
        map["musicbrainz_original_album_url"] = "MusicBrainz Original Album URL"
        
        map["musicbrainz track id"] = "MusicBrainz Recording Id"
        
        map["musicbrainz_relationship_url_name}"] = "MusicBrainz Relationship URLs"
        
        map["musicbrainz album release country"] = "MusicBrainz Release Country"
        
        map["musicbrainz release group id"] = "MusicBrainz Release Group Id"
        
        map["musicbrainz_release_group_url"] = "MusicBrainz Release Group URL"
        
        map["musicbrainz album id"] = "MusicBrainz Release Id"
        
        map["musicbrainz album status"] = "MusicBrainz Release Status"
        
        map["musicbrainz release track id"] = "MusicBrainz Release Track Id"
        
        map["musicbrainz album type"] = "MusicBrainz Release Type"
        
        map["musicbrainz_album_url"] = "MusicBrainz Release URL"
        
        map["musicbrainz trm id"] = "MusicBrainz TRM Id"
        
        map["script"] = "MusicBrainz Script"
        
        map["musicbrainz work id"] = "MusicBrainz Work Id"
        
        map["musiciancredits"] = "Musician Credits"
        
        map["url_official_artist_site"] = "Official Artist/Performer Webpage"
        
        map["official_audio_file_url"] = "Official Audio File Webpage"
        
        map["official_audio_source_url"] = "Official Audio Source Webpage"
        
        map["official_radio_url"] = "Official Internet Radio Station Webpage"
        
        map["original album"] = "Original Album"
        
        map["original artist"] = "Original Artist"
        
        map["original filename"] = "Original Filename"
        
        map["original lyricist"] = "Original Lyricist"
        
        map["original year"] = "Original Release Time"
        
        map["payment_url"] = "Payment Webpage"
        
        map["playcount"] = "Play Count"
        
        map["pricepaid"] = "Price Paid"
        
        map["produced_notice"] = "Produced Notice"
        
        map["publisher"] = "Publisher"
        
        map["label_url"] = "Publisher's Official Webpage"
        
        map["radio_station"] = "Radio Station"
        
        map["rating"] = "Rating"
        
        map["releasetime"] = "Release Time"
        
        map["rememberplaybackposition"] = "Remember Position"
        
        map["remixer"] = "Remixer"
        
        map["replaygain_album_gain"] = "ReplayGain Album Gain"
        
        map["replaygain_album_peak"] = "ReplayGain Album Peak"
        
        map["replaygain_track_gain"] = "ReplayGain Track Gain"
        
        map["replaygain_track_peak"] = "ReplayGain Track Peak"
        
        map["set subtitle"] = "Set Subtitle"
        
        map["skipwhenshuffling"] = "Skip When Shuffling"
        
        map["itunes_start_time"] = "Start Time"
        
        map["station_owner"] = "Station Owner"
        
        map["itunes_stop_time"] = "Stop Time"
        
        map["taggingtime"] = "Tagging Time"
        
        map["termsofuse"] = "Terms of Use"
        
        map["tmdb adult content"] = "tMDb Adult Content"
        
        map["tmdb name url"] = "tMDb Artwork URLs"
        
        map["tmdb budget"] = "tMDb Budget"
        
        map["tmdb collection name"] = "tMDb Collection Name"
        
        map["commercial_info_url"] = "tMDb Homepage"
        
        map["tmdb movie id"] = "tMDb Movie ID"
        
        map["tmdb original language"] = "tMDb Original Language (ISO)"
        
        map["tmdb original language (iso)"] = "tMDb Original Language (ISO)"
        
        map["tmdb production countries"] = "tMDb Production Countries"
        
        map["tmdb production countries (iso)"] = "tMDb Production Countries (ISO)"
        
        map["tmdb revenue"] = "tMDb Revenue"
        
        map["tmdb spoken languages"] = "tMDb Spoken Languages"
        
        map["tmdb spoken languages (iso)"] = "tMDb Spoken Languages (ISO)"
        
        map["tmdb tv id"] = "tMDb TV ID"
        
        map["track number text"] = "Track Position"
        
        map["ufid"] = "Unique File Identifier"
        
        map["itunes_volume_adjustment"] = "Volume Adjustment"
        
        map["yate album id"] = "Yate Album ID"
        
        map["yate track id"] = "Yate Track ID"
        
        return map
    }
}
