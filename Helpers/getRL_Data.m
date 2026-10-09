function [playerData,gameData] = getRL_Data(client,player)

if client.NumBytesAvailable > 0
    % Read the raw stream data
    raw_data = read(client, client.NumBytesAvailable, 'char');
    json_str = char(raw_data);

        % Parse the broadcasted JSON packet
        game_data = jsondecode(json_str);

        % Check if the payload contains player/spectator vehicle data
        % Note: Exact fields depend on your team/spectator status
        if isfield(game_data, 'Event') && strcmp(game_data.Event, 'UpdateState')

            if isfield(game_data, 'Data')
                Data = jsondecode(game_data.Data);
                if isfield(Data, 'Players')
                    player_list = Data.Players;

                    % Locate your vehicle's telemetry data block
                    % (Index 1 is typically you when practicing in Free Play)
                    if ~isempty(player_list)
                        if iscell(player_list)
                            for i = 1:numel(player_list)
                            if player_list{i}.Name == player
                                playerSelected = player_list{i};
                                break;
                            end
                            end
                            playerData = playerSelected;
                        else
                            playerData = player_list(1);
                        end
                        playerData.Speed = playerData.Speed*0.621371;                        
                    end
                end
                if isfield(Data, 'Game')
                    gameData = Data.Game;                    
                end
            end
        end    
end

end