function [playerData,teammateData,gameData] = getRL_Data(client,player)

if client.NumBytesAvailable > 0
    raw_data = read(client, client.NumBytesAvailable, 'char');
    json_str = char(raw_data);
        game_data = jsondecode(json_str);
        if isfield(game_data, 'Event') && strcmp(game_data.Event, 'UpdateState')
            if isfield(game_data, 'Data')
                Data = jsondecode(game_data.Data);
                if isfield(Data, 'Players')
                    player_list = Data.Players;
                    if ~isempty(player_list)
                        if iscell(player_list)
                            for i = 1:numel(player_list)
                            if player_list{i}.Name == player
                                playerSelected = player_list{i};
                                break;
                            end
                            end
                            teammateData = [];
                            playerData = playerSelected;
                            playerIdx = i;
                            playerTeam = playerData.TeamNum;
                            players = 1:numel(player_list);
                            players = players(players ~= playerIdx);
                            idx = 0;
                            for j = players
                                if player_list{j}.TeamNum == playerTeam
                                    idx = idx+1;
                                    teammateData(idx).Name = player_list{j}.Name;
                                    teammateData(idx).Score = player_list{j}.Score;
                                end
                            end
                        else
                            playerData = player_list(1);
                        end
                        playerData.Speed = playerData.Speed*0.621371;                        
                    end
                end
                if isfield(Data, 'Game')
                    gameData = Data.Game;
                    gameData.Ball.Speed = gameData.Ball.Speed*0.621371;  
                end
            end
        end    
end

end