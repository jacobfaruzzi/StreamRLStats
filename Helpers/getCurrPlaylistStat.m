function currPlaylist = getCurrPlaylistStat(allPlaylistStat,gameData)
idIDX = gameData.PlaylistId+10;
try
    allPlaylistStat(idIDX);
    if isempty(allPlaylistStat(idIDX).winNum)
        allPlaylistStat(idIDX).winNum    = 0;
        allPlaylistStat(idIDX).lossNum   = 0;
        allPlaylistStat(idIDX).streakNum = 0;
    end
catch
        allPlaylistStat(idIDX).winNum    = 0;
        allPlaylistStat(idIDX).lossNum   = 0;
        allPlaylistStat(idIDX).streakNum = 0;
end

currPlaylist.winNum    = allPlaylistStat(idIDX).winNum;
currPlaylist.lossNum   = allPlaylistStat(idIDX).lossNum;
currPlaylist.streakNum = allPlaylistStat(idIDX).streakNum;

end