import Foundation

// A playback chain specifically for stopping playback.
class StopPlaybackChain: PlaybackChain {
    
    init(_ player: PlayerProtocol, _ sequencer: SequencerProtocol, _ transcoder: TranscoderProtocol, _ profiles: PlaybackProfiles, _ preferences: PlaybackPreferences) {
        
        super.init()
        
        // TODO: Add save sound profile action ???
        
        _ = self.withAction(SavePlaybackProfileAction(profiles, preferences))
        .withAction(CancelWaitingOrTranscodingAction(transcoder))
        .withAction(HaltPlaybackAction(player))
        .withAction(EndPlaybackSequenceAction(sequencer))
    }
}
