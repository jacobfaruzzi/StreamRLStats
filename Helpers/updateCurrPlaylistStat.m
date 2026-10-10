function [currPlaylist,allPlaylistStat] = updateCurrPlaylistStat(allPlaylistStat,didWin,gameData)
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

if didWin
    allPlaylistStat(idIDX).winNum = allPlaylistStat(idIDX).winNum+1;
    if allPlaylistStat(idIDX).streakNum >= 0
        allPlaylistStat(idIDX).streakNum = allPlaylistStat(idIDX).streakNum+1;
    else
        allPlaylistStat(idIDX).streakNum = 1;
    end
else
    allPlaylistStat(idIDX).lossNum = allPlaylistStat(idIDX).lossNum+1;
    if allPlaylistStat(idIDX).streakNum <= 0
        allPlaylistStat(idIDX).streakNum = allPlaylistStat(idIDX).streakNum-1;
    else
        allPlaylistStat(idIDX).streakNum = -1;
    end
end

currPlaylist.winNum    = allPlaylistStat(idIDX).winNum;
currPlaylist.lossNum   = allPlaylistStat(idIDX).lossNum;
currPlaylist.streakNum = allPlaylistStat(idIDX).streakNum;

end