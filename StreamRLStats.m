function StreamRLStats()

addpath(genpath(pwd));

configs = RLConfigs();
player = configs.player;
connIn = configs.connIn;

mainFig = uifigure('Position',[2561 300 847 588.5],'Resize','off','Color',[.2 .2 .2]);
gameStatPanel = uipanel(mainFig,'Position',[10 448.8750 827 130],'BackgroundColor','k','BorderColor','k');
bckground1 = axes(gameStatPanel,'Position',[0 0 1 1],'Units','normalized');
img = imread('galaxy.jpg');
imshow(img, 'Parent', bckground1, 'XData', [0 827], 'YData', [0 130]);

score      = uilabel(gameStatPanel,'Position',[10.0000 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','w','Text','0');
uilabel(gameStatPanel,'Position',[10.0000 70 92.125 50],'Text','SCORE','HorizontalAlignment','center','FontSize',18,'FontColor','w');
goals      = uilabel(gameStatPanel,'Position',[112.125 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','w','Text','0');
uilabel(gameStatPanel,'Position',[112.125 70 92.125 50],'Text','GOALS','HorizontalAlignment','center','FontSize',18,'FontColor','w');
assists    = uilabel(gameStatPanel,'Position',[214.250 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','w','Text','0');
uilabel(gameStatPanel,'Position',[214.250 70 92.125 50],'Text','ASSISTS','HorizontalAlignment','center','FontSize',18,'FontColor','w');
saves      = uilabel(gameStatPanel,'Position',[316.375 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','w','Text','0');
uilabel(gameStatPanel,'Position',[316.375 70 92.125 50],'Text','SAVES','HorizontalAlignment','center','FontSize',20,'FontColor','w');
shots      = uilabel(gameStatPanel,'Position',[418.500 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','w','Text','0');
uilabel(gameStatPanel,'Position',[418.500 70 92.125 50],'Text','SHOTS','HorizontalAlignment','center','FontSize',18,'FontColor','w');
demos      = uilabel(gameStatPanel,'Position',[520.625 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','w','Text','0');
uilabel(gameStatPanel,'Position',[520.625 70 92.125 50],'Text','DEMOS','HorizontalAlignment','center','FontSize',18,'FontColor','w');
ballTouches    = uilabel(gameStatPanel,'Position',[622.750 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','w','Text','0');
uilabel(gameStatPanel,'Position',[622.750 70 92.125 50],'Text','BALL TOUCHES','HorizontalAlignment','center','FontSize',18,'FontColor','w');
carTouches = uilabel(gameStatPanel,'Position',[724.875 10 92.125 50],'HorizontalAlignment','center','FontSize',20,'FontColor','w','Text','0');
uilabel(gameStatPanel,'Position',[724.875 70 92.125 50],'Text','CAR TOUCHES','HorizontalAlignment','center','FontSize',18,'FontColor','w','WordWrap','on');


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

        dataOut = getRL_Data(client,player);
        jsonErr = 0;
        gameStatus.BackgroundColor = 'green';
        gameStatus.Value = 'Game is Connected';
        score.Text      = string(dataOut.Score);
        goals.Text      = string(dataOut.Goals);
        assists.Text    = string(dataOut.Assists);
        saves.Text      = string(dataOut.Saves);
        shots.Text      = string(dataOut.Shots);
        demos.Text      = string(dataOut.Demos);
        ballTouches.Text    = string(dataOut.Touches);
        carTouches.Text = string(dataOut.CarTouches);

        carSpeed.Value = dataOut.Speed;
        carBoost.Value = dataOut.Boost;
    catch JSON_ERR
        jsonErr = jsonErr+1;
        if jsonErr > 100
            gameStatus.BackgroundColor = 'red';
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