function StreamRLStats()

addpath(genpath(pwd));

configs = RLConfigs();
player = configs.player;
connIn = configs.connIn;
gameOver = false;
streakNum = 0;
winNum       = 0;
lossNum     = 0;

mainFig = uifigure('Position',[2561 300 847 728.5],'Resize','off','Color',[.2 .2 .2]);

gameStatPanel = uipanel(mainFig,'Position',[10 588.8750 827 130],'BackgroundColor','k','BorderColor','k');
bckground1 = axes(gameStatPanel,'Position',[0 0 1 1],'Units','normalized');
img = imread('galaxy.jpg');
imshow(img, 'Parent', bckground1, 'XData', [0 827], 'YData', [0 130]);

wins      = uilabel(gameStatPanel,'Position',[10.0000 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text',string(winNum));
uilabel(gameStatPanel,'Position',[10.0000 70 92.125 50],'Text','WINS','HorizontalAlignment','center','FontSize',18,'FontColor','y');
losses      = uilabel(gameStatPanel,'Position',[112.125 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text',string(lossNum));
uilabel(gameStatPanel,'Position',[112.125 70 92.125 50],'Text','LOSSES','HorizontalAlignment','center','FontSize',18,'FontColor','y');
streak    = uilabel(gameStatPanel,'Position',[214.250 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text',string(streakNum));
uilabel(gameStatPanel,'Position',[214.250 70 92.125 50],'Text','STREAK','HorizontalAlignment','center','FontSize',18,'FontColor','y');

teammate1    = uilabel(gameStatPanel,'Position',[316.375 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','');
teammate1Label = uilabel(gameStatPanel,'Position',[316.375 70 92.125 50],'HorizontalAlignment','center','FontSize',18,'FontColor','y','Text','','WordWrap','on');
teammate2    = uilabel(gameStatPanel,'Position',[418.500 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','');
teammate2Label = uilabel(gameStatPanel,'Position',[418.500 70 92.125 50],'HorizontalAlignment','center','FontSize',18,'FontColor','y','Text','','WordWrap','on');
teammate3    = uilabel(gameStatPanel,'Position',[520.625 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','');
teammate3Label = uilabel(gameStatPanel,'Position',[520.625 70 92.125 50],'HorizontalAlignment','center','FontSize',18,'FontColor','y','Text','','WordWrap','on');


playerStatPanel = uipanel(mainFig,'Position',[10 448.8750 827 130],'BackgroundColor','k','BorderColor','k');
bckground1 = axes(playerStatPanel,'Position',[0 0 1 1],'Units','normalized');
img = imread('galaxy.jpg');
imshow(img, 'Parent', bckground1, 'XData', [0 827], 'YData', [0 130]);

score      = uilabel(playerStatPanel,'Position',[10.0000 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','0');
uilabel(playerStatPanel,'Position',[10.0000 70 92.125 50],'Text','SCORE','HorizontalAlignment','center','FontSize',18,'FontColor','y');
goals      = uilabel(playerStatPanel,'Position',[112.125 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','0');
uilabel(playerStatPanel,'Position',[112.125 70 92.125 50],'Text','GOALS','HorizontalAlignment','center','FontSize',18,'FontColor','y');
assists    = uilabel(playerStatPanel,'Position',[214.250 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','0');
uilabel(playerStatPanel,'Position',[214.250 70 92.125 50],'Text','ASSISTS','HorizontalAlignment','center','FontSize',18,'FontColor','y');
saves      = uilabel(playerStatPanel,'Position',[316.375 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','0');
uilabel(playerStatPanel,'Position',[316.375 70 92.125 50],'Text','SAVES','HorizontalAlignment','center','FontSize',20,'FontColor','y');
shots      = uilabel(playerStatPanel,'Position',[418.500 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','0');
uilabel(playerStatPanel,'Position',[418.500 70 92.125 50],'Text','SHOTS','HorizontalAlignment','center','FontSize',18,'FontColor','y');
demos      = uilabel(playerStatPanel,'Position',[520.625 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','0');
uilabel(playerStatPanel,'Position',[520.625 70 92.125 50],'Text','DEMOS','HorizontalAlignment','center','FontSize',18,'FontColor','y');
ballTouches    = uilabel(playerStatPanel,'Position',[622.750 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','0');
uilabel(playerStatPanel,'Position',[622.750 70 92.125 50],'Text','TOUCHES','HorizontalAlignment','center','FontSize',18,'FontColor','y','WordWrap','on');
carTouches = uilabel(playerStatPanel,'Position',[724.875 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','y','Text','0');
uilabel(playerStatPanel,'Position',[724.875 70 92.125 50],'Text','BUMPS','HorizontalAlignment','center','FontSize',18,'FontColor','y','WordWrap','on');


carStatPanel = uipanel(mainFig,'Position',[10 10 827 428.8750],'BackgroundColor','k','BorderColor','k');
bckground2 = axes(carStatPanel,'Position',[0 0 1 1],'Units','normalized');
img = imread('galaxy.jpg');
imshow(img, 'Parent', bckground2, 'XData', [0 827], 'YData', [0 428.8750]);

carSpeed = uigauge(carStatPanel,"Limits",[0 51.45],'Position',[10 10 398.5 398.5],'BackgroundColor','k',...
    'FontColor','w','MajorTicks',[0 5 10 15 20 25 30 35 40 45 50 51.45],...
    'MajorTickLabels',{'0','5','10','15','20','25','30','35','40','45','50','MAX'},'FontSize',10,...
    'ScaleColorLimits',[0 31.5; 31.5 49.2; 49.2 51.45],'ScaleColors',[.39 .58 .93;.541 .169 .886;.502 0 .502]);
uilabel(carStatPanel,'Position',[159.25 40 100 50],'Text','SPEED','HorizontalAlignment','center','FontColor','w','FontSize',25,'FontWeight','bold');
carBoost = uigauge(carStatPanel,"Limits",[0 100],'Position',[418.5 10 398.5 398.5],'BackgroundColor','k',...
    'FontColor','w','MajorTicks',[0 10 20 30 40 50 60 70 80 90 100],...
    'MajorTickLabels',{'0','10','20','30','40','50','60','70','80','90','MAX'},...
    'ScaleColorLimits',[0 30; 30 60; 60 100],'ScaleColors',["red","yellow","green"]);
uilabel(carStatPanel,'Position',[567.75 40 100 50],'Text','BOOST','HorizontalAlignment','center','FontColor','w','FontSize',25,'FontWeight','bold');

gameStatus = uitextarea(carStatPanel,'Position',[338.5 396 175 25],'Value','Waiting for Game to Launch','HorizontalAlignment','center','BackgroundColor','red','FontColor','w');

pause(2);
jsonErr = 0;
client = connectRL(connIn);

while true
    try
        [playerData,teammateData,gameData] = getRL_Data(client,player);
        jsonErr = 0;
        if gameData.bHasWinner && gameOver
            continue;
        elseif ~gameData.bHasWinner && gameOver
            
            gameOver = false;
        end
        if isequal(gameStatus.BackgroundColor,[1 0 0]) || isequal(gameStatus.BackgroundColor,[0 1 0]) 
            teammate1.Text      = '';
            teammate1Label.Text = '';
            teammate2.Text      = '';
            teammate2Label.Text = '';
            teammate3.Text      = '';
            teammate3Label.Text = '';
        end
        gameStatus.BackgroundColor = 'green';
        gameStatus.FontColor = 'white';
        gameStatus.Value = 'Match has Started';
        score.Text      = string(playerData.Score);
        goals.Text      = string(playerData.Goals);
        assists.Text    = string(playerData.Assists);
        saves.Text      = string(playerData.Saves);
        shots.Text      = string(playerData.Shots);
        demos.Text      = string(playerData.Demos);
        ballTouches.Text    = string(playerData.Touches);
        carTouches.Text = string(playerData.CarTouches);

        carSpeed.Value = playerData.Speed;
        carBoost.Value = playerData.Boost;

        if ~isempty(teammateData)
            for teammateNum = 1:numel(teammateData)
                switch teammateNum
                    case 1
                        teammate1.Text      = string(teammateData(teammateNum).Score);
                        teammate1Label.Text = teammateData(teammateNum).Name;
                    case 2
                        teammate2.Text      = string(teammateData(teammateNum).Score);
                        teammate2Label.Text = teammateData(teammateNum).Name;
                    case 3
                        teammate3.Text      = string(teammateData(teammateNum).Score);
                        teammate3Label.Text = teammateData(teammateNum).Name;
                end
            end
        end


        if gameData.bHasWinner
            winnerIdx = find(strcmp(gameData.Winner,{gameData.Teams.Name}));
            didWin = playerData.TeamNum == gameData.Teams(winnerIdx).TeamNum;
            if didWin
                winNum = winNum+1;
                wins.Text = string(winNum);
                if streakNum >= 0
                    streakNum = streakNum+1;
                else
                    streakNum = 1;
                end
                streak.Text = "+"+string(streakNum);
            else
                lossNum = lossNum+1;
                losses.Text = string(lossNum);
                if streakNum <= 0
                    streakNum = streakNum-1;
                else
                    streakNum = -1;
                end
                streak.Text = string(streakNum);
            end
            gameOver = true;
            gameStatus.BackgroundColor = 'yellow';
            gameStatus.FontColor = 'black';
            gameStatus.Value = 'Match has Ended';
        end



    catch JSON_ERR
        jsonErr = jsonErr+1;
        if jsonErr > 100
            gameStatus.BackgroundColor = 'yellow';
            gameStatus.FontColor = 'black';
            gameStatus.Value = 'Waiting for Match to Start';
            % score.Value      = string(0);
            % goals.Value      = string(0);
            % assists.Value    = string(0);
            % saves.Value      = string(0);
            % shots.Value      = string(0);
            % demos.Value      = string(0);
            % touches.Value    = string(0);
            % carTouches.Value = string(0);

            carSpeed.Value = 0;
            carBoost.Value = 0;
        end
    end
    pause(0.01); % Yield to the system to maintain 100Hz processing loop
end

end